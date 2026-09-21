//
//  JKTextViewAutoLimiter.swift
//  JKSwiftExtension
//
//  Created by 王冲 on 2026/9/12.
//

import UIKit

// =============================================================================
// MARK: - 可感知粘贴动作的 UITextView (JKPasteAwareTextView)
// =============================================================================

/// 具备粘贴行为感知能力的多行文本输入框（UITextView 子类）
///
/// ### 设计背景与原理：
/// 1. **全通道覆盖捕获**：
///    - 同时重写 `paste(_:)` 与 `paste(itemProviders:)`，全面覆盖传统编辑弹窗、外接键盘、
///      iOS 16+ `UIEditMenuInteraction` 菜单及输入法预测候选栏中的粘贴入口。
/// 2. **消费即复位模式（Consumer Reset）**：
///    - 仅在此处标记 `isPasting = true`，不使用异步延迟自动重置，
///      避免因系统底层异步读取剪贴板引发提前复位为 `false` 的时序 Bug。
///    - 该状态交由外部监听管线（`JKTextViewAutoLimiter`）读取并主动复位。
open class JKPasteAwareTextView: UITextView {
    
    /// 标记当前是否正处于粘贴写入阶段
    public var isPasting: Bool = false
    
    /// 记录本次粘贴发生前的选中/光标区间（UTF-16 偏移，用于精准定位被替换的内容）
    /// - 粘贴替换选中文本时，仅靠文本长度差无法准确还原粘贴片段，故在此记录原始位置
    public var pasteReplacedRange: NSRange = NSRange(location: 0, length: 0)
    
    /// 传统 UIResponder 响应链中的粘贴入口（长按编辑菜单、Cmd + V 等）
    open override func paste(_ sender: Any?) {
        capturePasteReplacedRange()
        isPasting = true
        super.paste(sender)
    }
    
    /// 现代 iOS 系统级粘贴入口（遵循 UIPasteConfigurationSupporting 协议）
    /// 支持系统预测栏、拖放或新版系统编辑菜单分发的粘贴操作
    open override func paste(itemProviders: [NSItemProvider]) {
        capturePasteReplacedRange()
        isPasting = true
        super.paste(itemProviders: itemProviders)
    }
    
    /// 在粘贴动作真正执行前，记录当前被选中的文本区间
    private func capturePasteReplacedRange() {
        guard let range = selectedTextRange else {
            pasteReplacedRange = NSRange(location: text.utf16.count, length: 0)
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

private var kTVTextLimiterKey: Void?

// =============================================================================
// MARK: - 3. UITextView 输入限制扩展
// =============================================================================

public extension UITextView {
    
    /// 通过输入限制器安全赋值（自动应用清洗、截断、正则校验并更新内部状态）
    func setLimitedText(_ text: String?) {
        self.text = text
        // 手动触发系统变动通知，激活限制器的完整处理管线
        NotificationCenter.default.post(
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }
    
    /// 一键配置 UITextView 输入限制（中文拼音联想保护、光标中间截取、定向剪贴板清洗、正则过滤、超长事件、变动通知）
    /// - Parameters:
    ///   - maxCharacters: 最大字符/字节上限。传 `nil` 表示不限制字数。
    ///   - lengthType: 长度度量计算类型，默认按字符数 `.count` 统计；也可传 `.customCountOfChars` 按字节统计。
    ///   - regex: 字符集过滤正则表达式（白名单模式，如 `^[A-Za-z0-9\u{4e00}-\u{9fa5}\n]*$`；传 `nil` 不限制）。
    ///   - isInterceptString: 超长是否自动截取，默认 `true`；若为 `false` 则禁止该次超长输入。
    ///   - isRemovePasteboardNewlineCharacters: 粘贴内容时，是否仅自动清理粘贴片段首尾的换行符与空格。默认 `false`。注意：该功能依赖 `JKPasteAwareTextView` 子类感知粘贴动作，普通 `UITextView` 下不会生效。
    ///   - isMarkedTextRangeCanInput: 拼音高亮阶段是否做输入准入校验。默认 `false`。
    ///   - isCountMarkedTextInLimit: 拼音高亮阶段是否将拼音高亮文本也计入长度限制进行拦截。默认 `false`（不计入）；若为 `true` 则“已落字 + 拼音高亮”总长度超过上限时提前拦截拼音输入。
    ///   - textDidChangeHandler: 文本经过校验、清洗与截断后的最终稳定变动回调。
    ///   - exceedLimitHandler: 输入或粘贴超出最大限制时的事件回调。
    /// - Returns: 返回自身实例，支持链式调用
    @discardableResult
    func limitInput(
        maxCharacters: Int? = nil,
        lengthType: StringTypeLength = .count,
        regex: String? = nil,
        isInterceptString: Bool = true,
        isRemovePasteboardNewlineCharacters: Bool = false,
        isMarkedTextRangeCanInput: Bool = false,
        isCountMarkedTextInLimit: Bool = false,
        textDidChangeHandler: ((_ textView: UITextView, _ text: String) -> Void)? = nil,
        exceedLimitHandler: ((_ textView: UITextView, _ maxCharacters: Int) -> Void)? = nil
    ) -> Self {
        // 1. 防御性检查：解绑旧的监听
        if let oldLimiter = objc_getAssociatedObject(self, &kTVTextLimiterKey) as? JKTextViewAutoLimiter {
            oldLimiter.unbind()
        }
        
        // 2. 绑定新的限制器
        let limiter = JKTextViewAutoLimiter(
            textView: self,
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
        objc_setAssociatedObject(self, &kTVTextLimiterKey, limiter, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        // 若需要拼音阶段拦截，接管 delegate 做“输入前”拦截（并转发用户原有 delegate）
        limiter.bindDelegateIfNeeded(self)
        
        // 若当前已有文本，立即触发一次校验，使新配置对既有内容立即生效
        if !self.text.isEmpty {
            NotificationCenter.default.post(name: UITextView.textDidChangeNotification, object: self)
        }
        
        return self
    }
}

// =============================================================================
// MARK: - 4. UITextView 内部自闭环限制器实现
// =============================================================================

/// 负责实际监听、调度和截断 `UITextView` 文本变动的内部限制器（私有类，保持外部 API 封装干净）
private class JKTextViewAutoLimiter: NSObject, UITextViewDelegate {
    
    // MARK: - 核心配置属性
    
    /// 弱引用持有的目标多行输入框实例，避免 Notification 或闭包产生强引用环（Retain Cycle）
    private weak var textView: UITextView?
    
    /// 允许输入的最大字符/字节数上限；若为 `nil` 则代表不设上限，仅执行正则校验与拼音输入法保护
    private let maxCharacters: Int?
    
    /// 长度度量计算类型（例如：`.count` 纯字符数，或 `.customCountOfChars` 按中文/Emoji权重统计的字节数）[cite: 2]
    private let lengthType: StringTypeLength
    
    /// 字符集正则过滤规则（白名单模式，仅当文本满足该正则时才允许保留；注意多行输入需视情况包含 `\n`）
    private let regex: String?
    
    /// 超出最大字数限制时的行为模式：
    /// - `true`（截取模式）：自动从超标位置截除多余字符，尽可能保留合法长度内的文本
    /// - `false`（严格拒绝模式）：只要本次输入导致总长度越界，整次变动作废，直接回滚到上一次合法文本
    private let isInterceptString: Bool
    
    /// 剪贴板粘贴过滤开关：
    /// - `true`：仅在检测到粘贴行为时，自动去除粘贴内容片段前后的空格及换行符（不影响原有文本的空格）
    /// - `false`：忠实保留粘贴内容的所有原始换行与空格
    private let isRemovePasteboardNewlineCharacters: Bool
    
    /// 中文/日文输入法处于高亮拼音组合阶段时的准入校验开关：
    /// - `false`（默认推荐）：高亮拼音输入期间完全放行，保证系统输入法能完整完成拼音合成与选词交互[cite: 2]
    /// - `true`：如果既有文本已经达标，提前拦截新拼音的输入[cite: 2]
    private let isMarkedTextRangeCanInput: Bool
    
    /// 高亮阶段是否将拼音高亮文本计入长度限制进行拦截
    private let isCountMarkedTextInLimit: Bool
    
    /// 文本合法稳定后的变动回调
    private let textDidChangeHandler: ((UITextView, String) -> Void)?
    
    /// 超出最大字数限制时的外部业务事件回调（回传当前 `UITextView` 实例及上限值，便于业务层弹出 Toast 或触发震动）
    private let exceedLimitHandler: ((UITextView, Int) -> Void)?
    
    /// 记录最近一次“完全符合规则”（长度与正则均达标）的有效文本快照。
    /// 当用户输入非法正则字符或在严格拒入模式（`isInterceptString: false`）下超长时，以此文本作为基准回滚。
    private var lastValidText: String = ""
    
    /// 用户原有的 delegate（接管 delegate 做拼音拦截时保存，用于转发）
    private weak var userDelegate: UITextViewDelegate?
    
    /// 是否接管了 delegate
    private var ownsDelegate = false
    
    // MARK: - 初始化与解绑
    
    init(
        textView: UITextView,
        maxCharacters: Int?,
        lengthType: StringTypeLength,
        regex: String?,
        isInterceptString: Bool,
        isRemovePasteboardNewlineCharacters: Bool,
        isMarkedTextRangeCanInput: Bool,
        isCountMarkedTextInLimit: Bool,
        textDidChangeHandler: ((UITextView, String) -> Void)?,
        exceedLimitHandler: ((UITextView, Int) -> Void)?
    ) {
        self.textView = textView
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
        
        // 缓存当前输入框的初始有效内容
        self.lastValidText = textView.text ?? ""
        
        // 注册系统级 textDidChangeNotification，且 object 严格限定为当前实例
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onTextViewDidChange(_:)),
            name: UITextView.textDidChangeNotification,
            object: textView
        )
        
        // 监听开始编辑，同步回滚基准（覆盖“预填文本后开始编辑”的场景）
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onTextViewDidBeginEditing(_:)),
            name: UITextView.textDidBeginEditingNotification,
            object: textView
        )
    }
    
    /// 接管 delegate 做拼音阶段的“输入前”拦截，并保存用户原有 delegate 以便转发
    func bindDelegateIfNeeded(_ textView: UITextView) {
        guard isMarkedTextRangeCanInput || isCountMarkedTextInLimit else { return }
        if textView.delegate === self { return }
        userDelegate = textView.delegate
        textView.delegate = self
        ownsDelegate = true
    }
    
    /// 主动解除通知监听并清空弱引用，避免内存泄漏或野指针通知
    func unbind() {
        if ownsDelegate, let tv = textView, tv.delegate === self {
            tv.delegate = userDelegate
        }
        ownsDelegate = false
        userDelegate = nil
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: textView)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: textView)
        textView = nil
    }
    
    // MARK: - UITextViewDelegate：拼音阶段“输入前”拦截
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 拼音输入（marked text，range.length == 0）时做拼音阶段的长度拦截
        if !text.isEmpty, let max = maxCharacters, let markedRange = textView.markedTextRange, range.length == 0 {
            let current = textView.text ?? ""
            if isCountMarkedTextInLimit {
                // 拼音计入长度：“当前文本(含已输入拼音) + 本次新增” 超限则拒绝
                if current.jk.typeLengh(lengthType) + text.jk.typeLengh(lengthType) > max {
                    exceedLimitHandler?(textView, max)
                    _ = userDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text)
                    return false
                }
            }
            if isMarkedTextRangeCanInput {
                // 已落字文本已达上限则拒绝
                let ns = current as NSString
                let markedNSRange = rangeFromTextRange(textRange: markedRange, in: textView)
                let base = ns.replacingCharacters(in: markedNSRange, with: "")
                if base.jk.typeLengh(lengthType) >= max {
                    exceedLimitHandler?(textView, max)
                    _ = userDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text)
                    return false
                }
            }
        }
        // 转发给用户原有 delegate
        return userDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true
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
    
    /// 开始编辑时同步回滚基准：避免外部直接赋值（未经 setLimitedText）导致 lastValidText 陈旧而错误回滚
    @objc private func onTextViewDidBeginEditing(_ notification: Notification) {
        guard let tv = notification.object as? UITextView, tv == self.textView else { return }
        lastValidText = tv.text ?? ""
    }
    
    // MARK: - 核心文本变动处理管线
    
    @objc private func onTextViewDidChange(_ notification: Notification) {
        guard let tv = notification.object as? UITextView, tv == self.textView else { return }
        
        // 提前读取并复位粘贴标记：避免 marked 阶段提前 return 时标记残留，导致下一次非粘贴编辑被误判
        let awareTV = tv as? JKPasteAwareTextView
        let isPasting = awareTV?.isPasting ?? false
        awareTV?.isPasting = false
        
        // ---------------------------------------------------------------------
        // 阶段 1：中文/多语言输入法高亮拼音组合阶段保护
        // ---------------------------------------------------------------------
        if let markedRange = tv.markedTextRange {
            let markedNSRange = rangeFromTextRange(textRange: markedRange, in: tv)
            let fullText = tv.text ?? ""
            let baseContent = (fullText as NSString).replacingCharacters(in: markedNSRange, with: "")
            // 拼音/联想高亮期间：仅同步回滚基准为“去掉高亮后的已落字文本”。
            // 拼音字母级的长度拦截交由 delegate 的 shouldChangeTextIn 在“输入前”完成，
            // 此处不做事后回滚，避免破坏输入法拼音组合（导致拼音被 unmark、候选栏消失）。
            lastValidText = baseContent
            return
        }
        
        guard var currentText = tv.text else {
            // 文本被置空（nil）时，同步回滚基准为空，避免后续回滚到陈旧内容
            lastValidText = ""
            return
        }
        
        // ---------------------------------------------------------------------
        // 阶段 2：粘贴过滤 —— 仅对本次粘贴进来的片段清洗首尾换行与空格
        // ---------------------------------------------------------------------
        if isPasting && isRemovePasteboardNewlineCharacters {
            if let pasteboardString = UIPasteboard.general.string, !pasteboardString.isEmpty {
                // 1. 得到清洗首尾空格和换行后的纯净片段（例如："  A内容 " -> "A内容"）
                let cleanedPasteSnippet = pasteboardString.jk.removeBeginEndAllSapceAndLinefeed
                
                // 2. 统一以 UTF-16 口径计算偏移（UITextInput 的 offset 即 UTF-16 码元偏移）
                let nsCurrent = currentText as NSString
                let replacedRange = awareTV?.pasteReplacedRange ?? NSRange(location: nsCurrent.length, length: 0)
                let replacedLocation = max(0, min(replacedRange.location, nsCurrent.length))
                let replacedLength = max(0, min(replacedRange.length, nsCurrent.length - replacedLocation))
                
                // 3. 实际写入的片段跨度 = 长度增量 + 被替换掉的选区长度（兼容“粘贴覆盖选中文本”场景）
                let insertedUtf16Length = currentText.utf16.count - lastValidText.utf16.count + replacedLength
                
                if insertedUtf16Length > 0 {
                    let startIndex = stringIndex(fromUtf16Offset: replacedLocation, in: currentText)
                    let endIndex = stringIndex(fromUtf16Offset: replacedLocation + insertedUtf16Length, in: currentText)
                    
                    // 将本次粘贴进来的那段脏内容，精准替换为清洗后的纯净片段
                    currentText.replaceSubrange(startIndex..<endIndex, with: cleanedPasteSnippet)
                    tv.text = currentText
                    
                    // 重新对齐光标到清洗后片段末尾
                    let newCursorOffset = replacedLocation + cleanedPasteSnippet.utf16.count
                    if let newPos = tv.position(from: tv.beginningOfDocument, offset: newCursorOffset) {
                        tv.selectedTextRange = tv.textRange(from: newPos, to: newPos)
                    }
                }
            }
        }
        
        // ---------------------------------------------------------------------
        // 阶段 3（优先执行）：长度判定与超长截断
        // ---------------------------------------------------------------------
        // 先截断到合法上限，避免因超出区间长度直接在阶段 4 正则中被误清空
        if let maxCharacters = maxCharacters, currentText.jk.typeLengh(lengthType) > maxCharacters {
            // 触发超限事件通知
            exceedLimitHandler?(tv, maxCharacters)
            
            // 若未开启截取（isInterceptString == false），整次操作作废，直接恢复原状
            guard isInterceptString else {
                // 若上一版文本本身已超长（如预填超长），先截断到上限，避免回滚后仍超长导致永远无法修正
                if lastValidText.jk.typeLengh(lengthType) > maxCharacters {
                    let truncated = prefixFitting(lastValidText, limit: maxCharacters)
                    lastValidText = truncated
                    tv.text = truncated
                    textDidChangeHandler?(tv, truncated)
                } else {
                    tv.text = lastValidText
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
                if let selectedRange = tv.selectedTextRange {
                    cursor = tv.offset(from: tv.beginningOfDocument, to: selectedRange.start)
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
            
            tv.text = finalText
            currentText = finalText
            
            // 异步将光标精准定在截取末尾并同步滚动视窗
            let cursorTargetOffset = cursorUtf16
            DispatchQueue.main.async { [weak tv] in
                guard let tv = tv else { return }
                if let newPos = tv.position(from: tv.beginningOfDocument, offset: cursorTargetOffset) {
                    tv.selectedTextRange = tv.textRange(from: newPos, to: newPos)
                    tv.scrollRangeToVisible(NSRange(location: cursorTargetOffset, length: 0))
                }
            }
        }
        
        // ---------------------------------------------------------------------
        // 阶段 4：正则白名单校验（对最终留存的合法长度文本做校验）
        // ---------------------------------------------------------------------
        if let pattern = regex, !pattern.isEmpty {
            if !JKRegexHelper.isFullMatch(currentText, pattern: pattern) && !currentText.isEmpty {
                // 白名单过滤：剔除非法字符，保留合法字符（避免联想/批量输入含非法字符时整次被丢弃）
                guard let filtered = JKRegexHelper.filterWhitelistedCharacters(currentText, pattern: pattern) else {
                    // pattern 非字符类白名单，无法安全过滤：回退为整次输入作废
                    tv.text = lastValidText
                    return
                }
                if filtered.isEmpty {
                    // 全部为非法字符：整次输入作废，回滚到上一版合法文本
                    tv.text = lastValidText
                    return
                }
                tv.text = filtered
                currentText = filtered
                let newCursorOffset = filtered.utf16.count
                if let newPos = tv.position(from: tv.beginningOfDocument, offset: newCursorOffset) {
                    tv.selectedTextRange = tv.textRange(from: newPos, to: newPos)
                    tv.scrollRangeToVisible(NSRange(location: newCursorOffset, length: 0))
                }
            }
        }
        
        // ---------------------------------------------------------------------
        // 阶段 5：合法内容持久化与变动通知
        // ---------------------------------------------------------------------
        // 文本最终稳定且有变动时仅通知一次，杜绝多次重复回调
        if currentText != lastValidText {
            lastValidText = currentText
            textDidChangeHandler?(tv, currentText)
        }
    }
    
    /// 将系统的 UITextRange 转换为 Foundation 框架通用的 NSRange
    private func rangeFromTextRange(textRange: UITextRange, in tv: UITextView) -> NSRange {
        let location = tv.offset(from: tv.beginningOfDocument, to: textRange.start)
        let length = tv.offset(from: textRange.start, to: textRange.end)
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
