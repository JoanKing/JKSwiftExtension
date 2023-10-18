//
//  NSAttributedStringExtensionViewController.swift
//  JKSwiftExtension_Example
//
//  Created by IronMan on 2020/12/31.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class NSAttributedStringExtensionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、文本设置的基本扩展", "二、富文本的一些计算"]
        dataArray = [
            ["设置特定区域的字体大小", "设置特定文字的字体大小", "设置特定区域的字体颜色", "设置特定文字的字体颜色", "设置特定区域行间距", "设置特定文字行间距", "设置特定文字区域的下划线", "设置特定文字的下划线", "设置特定区域的删除线", "设置特定文字的删除线", "插入图片", "首行缩进", "设置特定区域的多个字体属性", "设置特定文字的多个字体属性"],
            ["计算富文本的宽度", "计算富文本的高度", "计算富文本的Size"]
        ]
    }
}

// MARK: - 二、富文本的一些计算
extension NSAttributedStringExtensionViewController {
    
    // MARK: 2.03、计算富文本的size
    @objc func test203() {
        // 通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        // 将行间距设置为20
        paraph.lineSpacing = 4
        // 剧中显示
        paraph.alignment = .left
        // 样式属性集合
        // 正值上偏，负值下偏
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.paragraphStyle: paraph] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: "用我三生烟火,换你一世迷离。", attributes: attributes)
        let attributedStringSize = attributedString.jk.sizeOfAttributedString(size: CGSize(width: 100, height: CGFloat(MAXFLOAT)))
        let testLabel = UILabel(frame: CGRect(x: 20, y: 50, width: 100, height: attributedStringSize.height))
        testLabel.backgroundColor = .yellow
        testLabel.numberOfLines = 0
        testLabel.attributedText = attributedString
        self.view.addSubview(testLabel)
        
        JKAsyncs.asyncDelay(3) {
        } _: {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 2.02、计算富文本的高度
    @objc func test202() {
        // 通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        // 将行间距设置为20
        paraph.lineSpacing = 4
        // 剧中显示
        paraph.alignment = .left
        // 样式属性集合
        // 正值上偏，负值下偏
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.paragraphStyle: paraph] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: "* If you are passionate about something, pursue it, no matter what any", attributes: attributes)
        
        let testLabel = UILabel(frame: CGRect(x: 20, y: 50, width: 100, height: attributedString.jk.heightOfAttributedString(size: CGSize(width: 100, height: CGFloat(MAXFLOAT)))))
        testLabel.backgroundColor = .yellow
        testLabel.numberOfLines = 0
        testLabel.attributedText = attributedString
        self.view.addSubview(testLabel)
    }
    
    // MARK: 2.01、计算富文本的宽度
    @objc func test201() {
        // 通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        // 将行间距设置为20
        paraph.lineSpacing = 4
        // 剧中显示
        paraph.alignment = .left
        // 样式属性集合
        // 正值上偏，负值下偏
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.paragraphStyle: paraph] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: "* If you are", attributes: attributes)
        let attributedStringWidth = attributedString.jk.widthOfAttributedString(size: CGSize(width: CGFloat(MAXFLOAT), height: 30))
        let testLabel = UILabel(frame: CGRect(x: 20, y: 50, width: attributedStringWidth, height: 30))
        testLabel.backgroundColor = .yellow
        testLabel.numberOfLines = 0
        testLabel.attributedText = attributedString
        self.view.addSubview(testLabel)
    }
}

// MARK: - 一、文本设置的基本扩展
extension NSAttributedStringExtensionViewController {
    
    // MARK: 1.14、设置特定文字的多个字体属性
    /// 设置特定文字的多个字体属性
    @objc func test114() {
        let content = "东临碣石，以观沧海。水何澹澹，山岛竦峙。树木丛生，百草丰茂。秋风萧瑟，洪波涌起。日月之行，若出其中；星汉灿烂，若出其里。幸甚至哉"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定文字的多个字体属性
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green] as [NSAttributedString.Key : Any]
        let attributedText = attributesContent.jk.setSpecificTextMoreAttributes("树木丛生，百草丰茂", attributes: attributes)
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributedText
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.13、设置特定区域的多个字体属性
    /// 设置特定区域的多个字体属性
    @objc func test113() {
        let content = "神龟虽寿，犹有竟时。螣蛇乘雾，终为土灰。老骥伏枥，志在千里。烈士暮年，壮心不已。盈缩之期，不但在天；养怡之福，可得永年。"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定区域的多个字体属性
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.green] as [NSAttributedString.Key : Any]
        let attributedText = attributesContent.jk.setSpecificRangeTextMoreAttributes(attributes: attributes, range: NSRange(location: 25, length: 4))
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributedText
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.12、首行缩进
    /// 首行缩进
    @objc func test112() {
        let content = "京口瓜洲一水间，钟山只隔数重山。春风又绿江南岸，明月何时照我还。"
        let attributesContent = NSAttributedString(string: content)
        // 首行缩进
        let attributes = attributesContent.jk.firstLineLeftEdge(100)
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.11、插入图片
    /// 插入图片
    @objc func test111() {
        // 上周排名变化数字
        let lastWeekRankingNumber = "\(890)"
        let lastWeekRankingNumberAttributes = NSMutableAttributedString(string: lastWeekRankingNumber)
        // 将图片添加到富文本
        let attributes = lastWeekRankingNumberAttributes.jk.insertImage(imgName: "rank_up", imgBounds: CGRect(x: 0, y: 0, width: 13, height: 14), imgIndex: lastWeekRankingNumber.count)
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 10)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(2, {
        }) {
            testLabel.attributedText = attributes
            JKAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 1.10、设置特定区域的删除线
    /// 设置特定区域的删除线
    @objc func test110() {
        let content = "我是一个小可爱"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定区域的删除线
        let attributes = attributesContent.jk.setSpecificRangeDeleteLine(color: UIColor.yellow, range: NSRange(location: 2, length: 3))
        
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.09、插入设置特定文字的删除线
    /// 插入设置特定文字的删除线
    @objc func test109() {
        let content = "我是一个小可爱"
        let attributesContent = NSAttributedString(string: content)
        // 插入设置特定文字的删除线
        let attributes = attributesContent.jk.setSpecificTextDeleteLine("一个", color: UIColor.yellow)
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.08、设置特定文字的下划线
    /// 设置特定文字的下划线
    @objc func test108() {
        let content = "我是一个小可爱"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定文字的下划线
        let attributes = attributesContent.jk.setSpecificTextUnderLine("一个", color: UIColor.yellow)
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.07、设置特定区域的下划线
    /// 设置特定区域的下划线
    @objc func test107() {
        let content = "我是一个小可爱"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定区域的下划线
        let attributes = attributesContent.jk.setSpecificTextUnderLine("一个", color: UIColor.yellow)
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.06、设置特定文字行间距
    /// 设置特定文字行间距
    @objc func test106() {
        let content = "十五从军征，八十始得归。道逢乡里人：家中有阿谁？遥看是君家，松柏冢累累。兔从狗窦入，雉从梁上飞。中庭生旅谷，井上生旅葵。舂谷持作饭，采葵持作羹。"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定文字行间距
        let attributes = attributesContent.jk.setSpecificTextLineSpace("家中有阿谁", lineSpace: 20, alignment: .center)
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: 400))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.05、设置特定区域行行间距
    /// 设置特定区域行间距
    @objc func test105() {
        let content = "十五从军征，八十始得归。道逢乡里人：家中有阿谁？遥看是君家，松柏冢累累。兔从狗窦入，雉从梁上飞。中庭生旅谷，井上生旅葵。舂谷持作饭，采葵持作羹。"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定区域行间距
        let attributes = attributesContent.jk.setSpecificRangeTextLineSpace(lineSpace: 20, alignment: .center, range: NSRange(location: 10, length: 10))
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: 400))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.04、设置特定文字的字体颜色
    /// 设置特定文字的字体颜色
    @objc func test104() {
        let content = "十五从军征，八十始得归。道逢乡里人：家中有阿谁？遥看是君家，松柏冢累累。兔从狗窦入，雉从梁上飞。中庭生旅谷，井上生旅葵。舂谷持作饭，采葵持作羹。"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定文字的字体颜色
        let attributes = attributesContent.jk.setSpecificTextColor("家", color: UIColor.yellow)
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: 400))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.03、设置特定区域的字体颜色
    /// 设置特定区域的字体颜色
    @objc func test103() {
        let content = "春宵一刻值千金，花有清香月有阴。歌管楼台声细细，秋千院落夜沉沉。"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定区域的字体颜色
        let attributes = attributesContent.jk.setSpecificRangeTextColor(color: .yellow, range: NSRange(location: 2, length: 5))
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: 400))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.02、设置特定文字的字体大小
    /// 设置特定文字的字体大小
    @objc func test102() {
        let content = "春宵一刻值千金，花有清香月有阴。歌管楼台声细细，秋千院落夜沉沉。"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定区域的字体颜色
        let attributes = attributesContent.jk.setSpecificTextFont("花有清香月有阴", font: UIFont.jk.textR(16))
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: 400))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.01、设置特定区域的字体大小
    /// 设置特定区域的字体大小
    @objc func test101() {
        let content = "春宵一刻值千金，花有清香月有阴。歌管楼台声细细，秋千院落夜沉沉。"
        let attributesContent = NSAttributedString(string: content)
        // 设置特定区域的字体大小
        let attributes = attributesContent.jk.setRangeFontText(font: UIFont.jk.textB(20), range: NSRange(location: 2, length: 6))
  
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: jk_kScreenW - 100, height: 400))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.attributedText = attributes
        testLabel.textColor = .white
        self.view.addSubview(testLabel)
        JKAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
}
