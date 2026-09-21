//
//  JKTextFieldAutoLimiter.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2026/9/12.
//

import UIKit

// =============================================================================
// MARK: - 可感知粘贴动作的 UITextField (JKPasteAwareTextField)
// =============================================================================

/// 具备粘贴行为感知能力的 UITextField 子类
///
/// ### 设计背景与原理：
/// 1. **系统粘贴通道分发差异**：
///    - 传统编辑菜单与快捷键通常走 `UIResponder` 的 `paste(_:)` 方法；
///    - iOS 11+ / iOS 15+ 现代系统全局菜单（`UIEditMenuInteraction`）以及键盘上方预测候选栏的“粘贴”，
///      会通过 `UIPasteConfigurationSupporting` 协议的 `paste(itemProviders:)` 进行异步分发。
///    - 本类同时重写这两个入口，确保无论用户通过何种方式触发粘贴，均能精准捕获。
/// 2. **生命周期协同（消费模式）**：
///    - 此处仅将 `isPasting` 标记为 `true`，**不使用异步延迟重置**，
///      避免由于系统底层异步读取剪贴板导致 `false` 提前生效的时序竞争问题。
///    - 状态由后续监听管线（如 `JKTextFieldAutoLimiter`）消费完毕后主动复位为 `false`。
open class JKPasteAwareTextField: UITextField {
    
    /// 标记当前是否正处于粘贴写入阶段
    /// - 外部限制器或代理可通过读取此标记判断文本增量是否来自于剪贴板粘贴
    public var isPasting: Bool = false
    
    /// 记录本次粘贴发生前的选中/光标区间（UTF-16 偏移，用于精准定位被替换的内容）
    /// - 粘贴替换选中文本时，仅靠文本长度差无法准确还原粘贴片段，故在此记录原始位置
    public var pasteReplacedRange: NSRange = NSRange(location: 0, length: 0)
    
    /// 传统 UIResponder 响应链中的粘贴入口（长按弹出气泡菜单、外接键盘 Cmd + V 等）
    /// - Parameter sender: 触发此动作的发送者（如 UIMenuController）
    open override func paste(_ sender: Any?) {
        capturePasteReplacedRange()
        isPasting = true
        super.paste(sender)
    }
    
    /// 现代 iOS 系统级粘贴入口（遵循 UIPasteConfigurationSupporting 协议）
    /// - 支持通过拖拽、键盘上方预测建议栏、或 iOS 16+ 新版系统编辑菜单进行的数据粘贴
    /// - Parameter itemProviders: 剪贴板传递的数据提供者数组
    open override func paste(itemProviders: [NSItemProvider]) {
        capturePasteReplacedRange()
        isPasting = true
        super.paste(itemProviders: itemProviders)
    }
    
    /// 在粘贴动作真正执行前，记录当前被选中的文本区间
    private func capturePasteReplacedRange() {
        guard let range = selectedTextRange else {
            pasteReplacedRange = NSRange(location: text?.utf16.count ?? 0, length: 0)
            return
        }
        let location = offset(from: beginningOfDocument, to: range.start)
        let length = offset(from: range.start, to: range.end)
        pasteReplacedRange = NSRange(location: location, length: length)
    }
}

// =============================================================================
// MARK: - 2. 关联对象静态 Key
// =============================================================================

/// 关联对象（Associated Object）的静态内存地址 Key
/// - 使用 `Void?` 规范占位，内存开销为 0，且彻底避免编译器未使用警告
private var kTFTextLimiterKey: Void?

// =============================================================================
// MARK: - 3. UITextField 输入限制扩展
// =============================================================================

public extension UITextField {
    
    /// 通过输入限制器安全赋值（自动应用清洗、截断、正则校验并更新内部状态）
    func setLimitedText(_ text: String?) {
        self.text = text
        // 手动派发 editingChanged 事件，激活限制器的完整处理管线
        sendActions(for: .editingChanged)
    }
    
    /// 一键配置文本输入限制器（开箱即用、自闭环生命周期、免手动代理管理）
    ///
    /// ### 核心功能特性：
    /// 1. **中文输入法高亮保护**：输入拼音期间（`markedTextRange != nil`）不打断输入法，杜绝联想词点击后输入框变空的问题。
    /// 2. **精准字符/字节限制**：支持按 `.count`（字符个数）或 `.customCountOfChars`（汉字/Emoji/字节加权）统计。
    /// 3. **全场景插入/粘贴截断**：无论是在末尾追加、在中间光标处插入，还是批量粘贴超长文本，均能保留原有前后文本并只截断超长部分。
    /// 4. **无感光标精准复位**：基于 `UTF-16` 偏移计算，光标始终稳定吸附在本次插入/粘贴文本的末尾。
    /// 5. **粘贴换行过滤**：仅在检测到粘贴操作时，自动过滤前后的换行符与多余空格。
    /// 6. **白名单正则过滤**：支持通过白名单正则动态过滤非法字符。
    /// 7. **超长事件通知**：超出长度限制时（包括截断与拒入）触发回调通知外部业务层。
    /// 8. **稳定内容变动回调**：文本完成所有清洗、截断并最终落字后触发单次变动通知，避免多次重复打印。
    ///
    /// - Parameters:
    ///   - maxCharacters: 允许输入的最大长度上限。传 `nil`（默认值）表示不限制长度。
    ///   - lengthType: 长度度量计算类型，默认按字符个数 `.count` 统计；也可传 `.customCountOfChars`。
    ///   - regex: 字符集过滤正则表达式（仅支持字符白名单正则，如 `^[0-9]*$`；传 `nil` 表示不限制）。
    ///   - isInterceptString: 超出字数限制时，多余文字是否自动截取。默认 `true`（截取）；若为 `false` 则完全禁止该次超长输入。
    ///   - isRemovePasteboardNewlineCharacters: 粘贴内容时，是否自动移除前后换行符与多余空格。默认 `false`。注意：该功能依赖 `JKPasteAwareTextField` 子类感知粘贴动作，普通 `UITextField` 下不会生效。
    ///   - isMarkedTextRangeCanInput: 拼音高亮阶段是否做输入准入校验。默认 `false`（高亮拼音全放行）；若为 `true` 则在已有字符已达上限时提前阻止输入拼音。
    ///   - isCountMarkedTextInLimit: 拼音高亮阶段是否将拼音高亮文本也计入长度限制进行拦截。默认 `false`（不计入）；若为 `true` 则“已落字 + 拼音高亮”总长度超过上限时提前拦截拼音输入。
    ///   - textDidChangeHandler: 文本经过校验、清洗与截断后的最终稳定变动回调。
    ///   - exceedLimitHandler: 输入或粘贴超出最大限制时的事件回调。
    /// - Returns: 返回 `UITextField` 自身实例，支持链式调用。
    @discardableResult
    func limitInput(
        maxCharacters: Int? = nil,
        lengthType: StringTypeLength = .count,
        regex: String? = nil,
        isInterceptString: Bool = true,
        isRemovePasteboardNewlineCharacters: Bool = false,
        isMarkedTextRangeCanInput: Bool = false,
        isCountMarkedTextInLimit: Bool = false,
        textDidChangeHandler: ((_ textField: UITextField, _ text: String) -> Void)? = nil,
        exceedLimitHandler: ((_ textField: UITextField, _ maxCharacters: Int) -> Void)? = nil
    ) -> Self {
        // 步骤 1：防御性检查 —— 防止在 UITableViewCell 复用或多次配置时重复添加 Target 监听
        if let oldLimiter = objc_getAssociatedObject(self, &kTFTextLimiterKey) as? JKTextFieldAutoLimiter {
            oldLimiter.unbind()
        }
        
        // 步骤 2：实例化独立的限制器对象
        let limiter = JKTextFieldAutoLimiter(
            textField: self,
            maxCharacters: maxCharacters,
            lengthType: lengthType,
            regex: regex,
            isInterceptString: isInterceptString,
            isRemovePasteboardNewlineCharacters: isRemovePasteboardNewlineCharacters,
            isMarkedTextRangeCanInput: isMarkedTextRangeCanInput,
            isCountMarkedTextInLimit: isCountMarkedTextInLimit,
            textDidChangeHandler: textDidChangeHandler,
            exceedLimitHandler: exceedLimitHandler
        )
        
        // 步骤 3：利用 ObjC Runtime 将限制器与当前 UITextField 强关联，使其生命周期与输入框同生共死
        objc_setAssociatedObject(self, &kTFTextLimiterKey, limiter, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        // 若需要拼音阶段拦截，接管 delegate 做“输入前”拦截（并转发用户原有 delegate）
        limiter.bindDelegateIfNeeded(self)
        
        // 若当前已有文本，立即触发一次校验，使新配置对既有内容立即生效
        if !(self.text ?? "").isEmpty {
            self.sendActions(for: .editingChanged)
        }
        
        return self
    }
}

// =============================================================================
// MARK: - 4. 内部自闭环限制器实现
// =============================================================================

/// 负责实际监听、调度和截断文本变动的内部限制器
private class JKTextFieldAutoLimiter: NSObject, UITextFieldDelegate {
    
    /// 弱引用持有的目标输入框实例，避免循环引用
    private weak var textField: UITextField?
    
    /// 允许的最大字符/字节数，为 nil 时不设长度上限
    private let maxCharacters: Int?
    
    /// 长度度量类型（.count 或 .customCountOfChars）
    private let lengthType: StringTypeLength
    
    /// 字符集正则过滤规则
    private let regex: String?
    
    /// 超出长度时是否截取
    private let isInterceptString: Bool
    
    /// 粘贴时是否清理换行符
    private let isRemovePasteboardNewlineCharacters: Bool
    
    /// 高亮状态下是否限制拼音输入
    private let isMarkedTextRangeCanInput: Bool
    
    /// 高亮阶段是否将拼音高亮文本计入长度限制进行拦截
    private let isCountMarkedTextInLimit: Bool
    
    /// 文本合法稳定后的变动回调
    private let textDidChangeHandler: ((UITextField, String) -> Void)?
    
    /// 超长事件回调
    private let exceedLimitHandler: ((UITextField, Int) -> Void)?
    
    /// 记录最近一次符合规则的合法文本内容，用于非法输入时的安全回滚
    private var lastValidText: String = ""
    
    /// 用户原有的 delegate（接管 delegate 做拼音拦截时保存，用于转发）
    private weak var userDelegate: UITextFieldDelegate?
    
    /// 是否接管了 delegate
    private var ownsDelegate = false
    
    init(
        textField: UITextField,
        maxCharacters: Int?,
        lengthType: StringTypeLength,
        regex: String?,
        isInterceptString: Bool,
        isRemovePasteboardNewlineCharacters: Bool,
        isMarkedTextRangeCanInput: Bool,
        isCountMarkedTextInLimit: Bool,
        textDidChangeHandler: ((UITextField, String) -> Void)?,
        exceedLimitHandler: ((UITextField, Int) -> Void)?
    ) {
        self.textField = textField
        self.maxCharacters = maxCharacters
        self.lengthType = lengthType
        self.regex = regex
        self.isInterceptString = isInterceptString
        self.isRemovePasteboardNewlineCharacters = isRemovePasteboardNewlineCharacters
        self.isMarkedTextRangeCanInput = isMarkedTextRangeCanInput
        self.isCountMarkedTextInLimit = isCountMarkedTextInLimit
        self.textDidChangeHandler = textDidChangeHandler
        self.exceedLimitHandler = exceedLimitHandler
        super.init()
        
        self.lastValidText = textField.text ?? ""
        textField.addTarget(self, action: #selector(onEditingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(onEditingDidBegin), for: .editingDidBegin)
    }
    
    /// 接管 delegate 做拼音阶段的“输入前”拦截，并保存用户原有 delegate 以便转发
    func bindDelegateIfNeeded(_ textField: UITextField) {
        guard isMarkedTextRangeCanInput || isCountMarkedTextInLimit else { return }
        if textField.delegate === self { return }
        userDelegate = textField.delegate
        textField.delegate = self
        ownsDelegate = true
    }
    
    /// 主动解除事件监听并释放引用
    func unbind() {
        if ownsDelegate, let tf = textField, tf.delegate === self {
            tf.delegate = userDelegate
        }
        ownsDelegate = false
        userDelegate = nil
        textField?.removeTarget(self, action: #selector(onEditingChanged), for: .editingChanged)
        textField?.removeTarget(self, action: #selector(onEditingDidBegin), for: .editingDidBegin)
        textField = nil
    }
    
    // MARK: - UITextFieldDelegate：拼音阶段“输入前”拦截
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 拼音输入（marked text，range.length == 0）时做拼音阶段的长度拦截
        if !string.isEmpty, let max = maxCharacters, let markedRange = textField.markedTextRange, range.length == 0 {
            let current = textField.text ?? ""
            if isCountMarkedTextInLimit {
                // 拼音计入长度：“当前文本(含已输入拼音) + 本次新增” 超限则拒绝
                if current.jk.typeLengh(lengthType) + string.jk.typeLengh(lengthType) > max {
                    exceedLimitHandler?(textField, max)
                    _ = userDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string)
                    return false
                }
            }
            if isMarkedTextRangeCanInput {
                // 已落字文本已达上限则拒绝
                let ns = current as NSString
                let markedNSRange = rangeFromTextRange(textRange: markedRange, in: textField)
                let base = ns.replacingCharacters(in: markedNSRange, with: "")
                if base.jk.typeLengh(lengthType) >= max {
                    exceedLimitHandler?(textField, max)
                    _ = userDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string)
                    return false
                }
            }
        }
        // 转发给用户原有 delegate
        return userDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    /// 反映 userDelegate 是否响应某 selector，避免 UIKit 用 responds(to:) 预检查时因本类未实现而跳过转发
    override func responds(to aSelector: Selector!) -> Bool {
        if super.responds(to: aSelector) {
            return true
        }
        return userDelegate?.responds(to: aSelector) ?? false
    }
    
    /// 将未实现的 delegate 方法转发给用户原有 delegate
    override func forwardingTarget(for selector: Selector) -> Any? {
        if let userDelegate = userDelegate, userDelegate.responds(to: selector) {
            return userDelegate
        }
        return super.forwardingTarget(for: selector)
    }
    
    /// 开始编辑时同步回滚基准：覆盖“预填文本后开始编辑”的场景，
    /// 避免因外部直接赋值（未经 setLimitedText）导致 lastValidText 陈旧而错误回滚
    @objc private func onEditingDidBegin(_ tf: UITextField) {
        lastValidText = tf.text ?? ""
    }
    
    // MARK: - 核心文本变动处理管线
    
    @objc private func onEditingChanged(_ tf: UITextField) {
        
        // 提前读取并复位粘贴标记：避免 marked 阶段提前 return 时标记残留，导致下一次非粘贴编辑被误判
        let awareTF = tf as? JKPasteAwareTextField
        let isPasting = awareTF?.isPasting ?? false
        awareTF?.isPasting = false
        
        // ---------------------------------------------------------------------
        // 阶段 1：中文/多语言输入法高亮拼音阶段保护
        // ---------------------------------------------------------------------
        if let markedRange = tf.markedTextRange {
            let markedNSRange = rangeFromTextRange(textRange: markedRange, in: tf)
            let fullText = tf.text ?? ""
            let baseContent = (fullText as NSString).replacingCharacters(in: markedNSRange, with: "")
            // 拼音/联想高亮期间：仅同步回滚基准为“去掉高亮后的已落字文本”。
            // 拼音字母级的长度拦截交由 delegate 的 shouldChangeCharactersIn 在“输入前”完成，
            // 此处不做事后回滚，避免破坏输入法拼音组合（导致拼音被 unmark、候选栏消失）。
            lastValidText = baseContent
            return
        }
        
        guard var currentText = tf.text else {
            // 文本被置空（nil）时，同步回滚基准为空，避免后续回滚到陈旧内容
            lastValidText = ""
            return
        }
        
        // ---------------------------------------------------------------------
        // 阶段 2：粘贴过滤 —— 仅对本次粘贴进来的片段清洗首尾换行与空格
        // ---------------------------------------------------------------------
        if isPasting && isRemovePasteboardNewlineCharacters {
            if let pasteboardString = UIPasteboard.general.string, !pasteboardString.isEmpty {
                // 1. 得到清洗首尾空格和换行后的纯净片段（如："  A内容 " -> "A内容"）
                let cleanedPasteSnippet = pasteboardString.jk.removeBeginEndAllSapceAndLinefeed
                
                // 2. 统一以 UTF-16 口径计算偏移（UITextInput 的 offset 即 UTF-16 码元偏移）
                let nsCurrent = currentText as NSString
                let replacedRange = awareTF?.pasteReplacedRange ?? NSRange(location: nsCurrent.length, length: 0)
                let replacedLocation = max(0, min(replacedRange.location, nsCurrent.length))
                let replacedLength = max(0, min(replacedRange.length, nsCurrent.length - replacedLocation))
                
                // 3. 实际写入的片段跨度 = 长度增量 + 被替换掉的选区长度（兼容“粘贴覆盖选中文本”场景）
                let insertedUtf16Length = currentText.utf16.count - lastValidText.utf16.count + replacedLength
                
                if insertedUtf16Length > 0 {
                    let startIndex = stringIndex(fromUtf16Offset: replacedLocation, in: currentText)
                    let endIndex = stringIndex(fromUtf16Offset: replacedLocation + insertedUtf16Length, in: currentText)
                    
                    // 将本次粘贴进来的那段脏内容，精准替换为清洗后的纯净片段
                    currentText.replaceSubrange(startIndex..<endIndex, with: cleanedPasteSnippet)
                    tf.text = currentText
                    
                    // 重新校正光标到清洗后文字的末尾
                    let newCursorOffset = replacedLocation + cleanedPasteSnippet.utf16.count
                    if let newPos = tf.position(from: tf.beginningOfDocument, offset: newCursorOffset) {
                        tf.selectedTextRange = tf.textRange(from: newPos, to: newPos)
                    }
                }
            }
        }
        
        // ---------------------------------------------------------------------
        // 🌟 阶段 3（提前）：长度判定与截断（必须先修剪超长部分，再去验正则）
        // ---------------------------------------------------------------------
        if let maxCharacters = maxCharacters, currentText.jk.typeLengh(lengthType) > maxCharacters {
            // 触发超出长度事件通知
            exceedLimitHandler?(tf, maxCharacters)
            
            // 如果不允许截取，直接回滚到上一版合法文本
            guard isInterceptString else {
                // 若上一版文本本身已超长（如预填超长），先截断到上限，避免回滚后仍超长导致永远无法修正
                if lastValidText.jk.typeLengh(lengthType) > maxCharacters {
                    let truncated = prefixFitting(lastValidText, limit: maxCharacters)
                    lastValidText = truncated
                    tf.text = truncated
                    textDidChangeHandler?(tf, truncated)
                } else {
                    tf.text = lastValidText
                }
                return
            }
            
            // 依据编辑方向截断，避免误删原有文本
            let finalText: String
            let cursorUtf16: Int
            let isAppend = currentText.hasPrefix(lastValidText)
            let isPrepend = !isAppend && currentText.hasSuffix(lastValidText)
            
            if isAppend {
                // 末尾追加：保留开头 ≤ 上限 的字节
                finalText = prefixFitting(currentText, limit: maxCharacters)
                cursorUtf16 = finalText.utf16.count
            } else if isPrepend {
                // 开头插入：保留末尾 ≤ 上限 的字节
                finalText = suffixFitting(currentText, limit: maxCharacters)
                cursorUtf16 = max(0, finalText.utf16.count - lastValidText.utf16.count)
            } else {
                // 中间插入/替换：优先保留后缀原文本，再保留前缀
                let nsCurrent = currentText as NSString
                var cursor = nsCurrent.length
                if let selectedRange = tf.selectedTextRange {
                    cursor = tf.offset(from: tf.beginningOfDocument, to: selectedRange.start)
                }
                cursor = max(0, min(cursor, nsCurrent.length))
                let cursorIndex = stringIndex(fromUtf16Offset: cursor, in: currentText)
                let prefixText = String(currentText[..<cursorIndex])
                let suffixText = String(currentText[cursorIndex...])
                
                let suffixLen = suffixText.jk.typeLengh(lengthType)
                let prefixAllowance = maxCharacters - suffixLen
                let trimmedPrefix = prefixAllowance > 0 ? prefixFitting(prefixText, limit: prefixAllowance) : ""
                let remaining = maxCharacters - trimmedPrefix.jk.typeLengh(lengthType)
                let trimmedSuffix = remaining > 0 ? prefixFitting(suffixText, limit: remaining) : ""
                
                finalText = trimmedPrefix + trimmedSuffix
                cursorUtf16 = trimmedPrefix.utf16.count
            }
            
            tf.text = finalText
            currentText = finalText
            
            let cursorTargetOffset = cursorUtf16
            DispatchQueue.main.async { [weak tf] in
                guard let tf = tf else { return }
                if let newPos = tf.position(from: tf.beginningOfDocument, offset: cursorTargetOffset) {
                    tf.selectedTextRange = tf.textRange(from: newPos, to: newPos)
                }
            }
        }
        
        // ---------------------------------------------------------------------
        // 🌟 阶段 4：正则白名单校验（对截取后的合法长度文本做纯字符集校验）
        // ---------------------------------------------------------------------
        if let pattern = regex, !pattern.isEmpty {
            if !JKRegexHelper.isFullMatch(currentText, pattern: pattern) && !currentText.isEmpty {
                // 白名单过滤：剔除非法字符，保留合法字符（避免联想/批量输入含非法字符时整次被丢弃）
                guard let filtered = JKRegexHelper.filterWhitelistedCharacters(currentText, pattern: pattern) else {
                    // pattern 非字符类白名单，无法安全过滤：回退为整次输入作废
                    tf.text = lastValidText
                    return
                }
                if filtered.isEmpty {
                    // 全部为非法字符：整次输入作废，回滚到上一版合法文本
                    tf.text = lastValidText
                    return
                }
                tf.text = filtered
                currentText = filtered
                let newCursorOffset = filtered.utf16.count
                if let newPos = tf.position(from: tf.beginningOfDocument, offset: newCursorOffset) {
                    tf.selectedTextRange = tf.textRange(from: newPos, to: newPos)
                }
            }
        }
        
        // ---------------------------------------------------------------------
        // 阶段 5：合法内容持久化与变动通知
        // ---------------------------------------------------------------------
        if currentText != lastValidText {
            lastValidText = currentText
            textDidChangeHandler?(tf, currentText)
        }
    }
    
    /// UITextRange 转换为 NSRange 工具方法
    private func rangeFromTextRange(textRange: UITextRange, in tf: UITextField) -> NSRange {
        let location = tf.offset(from: tf.beginningOfDocument, to: textRange.start)
        let length = tf.offset(from: textRange.start, to: textRange.end)
        return NSMakeRange(location, length)
    }
    
    /// 将 UITextInput 提供的 UTF-16 码元偏移量转换为 String 的字符索引
    /// - 光标/选区位置始终落在字符簇（grapheme cluster）边界上，因此该转换安全无越界
    private func stringIndex(fromUtf16Offset offset: Int, in string: String) -> String.Index {
        let ns = string as NSString
        let clamped = max(0, min(offset, ns.length))
        if let lower = Range(NSRange(location: clamped, length: 0), in: string)?.lowerBound {
            return lower
        }
        return string.endIndex
    }
    
    /// 截取开头的若干字符，使总长度（按 lengthType 计算）不超过 limit
    private func prefixFitting(_ text: String, limit: Int) -> String {
        var result = ""
        var total = 0
        for ch in text {
            let l = String(ch).jk.typeLengh(lengthType)
            if total + l > limit { break }
            total += l
            result.append(ch)
        }
        return result
    }
    
    /// 截取末尾的若干字符，使总长度（按 lengthType 计算）不超过 limit
    private func suffixFitting(_ text: String, limit: Int) -> String {
        var kept: [Character] = []
        var total = 0
        for ch in text.reversed() {
            let l = String(ch).jk.typeLengh(lengthType)
            if total + l > limit { break }
            total += l
            kept.append(ch)
        }
        return String(kept.reversed())
    }
    
    deinit {
        unbind()
    }
}
