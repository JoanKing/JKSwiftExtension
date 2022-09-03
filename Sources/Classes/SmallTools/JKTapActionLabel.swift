//
//  JKTapActionLabel.swift
//  JKSwiftExtension
//
//  Created by IronMan on 2021/1/8.
//

import UIKit

public class JKTapActionLabel: UIView {

    @objc var attString: NSMutableAttributedString = NSMutableAttributedString(string: "输入字符串为空")
    @objc var rectFrame: CTFrame?
    @objc var startIndex: String?
    @objc var endIndex: String?
    @objc var reactfunc: () -> () = {}
    @objc var tapStringArray: Array<NSString>! = Array()
    @objc var reactFunctionArray: Array<Any>! = Array()
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.textMatrix = CGAffineTransform.identity
        context!.translateBy(x: 0, y: rect.size.height)
        context!.scaleBy(x: 1, y: -1)
        let path = CGMutablePath()
        path.addRect(rect)
        let frameSetter = CTFramesetterCreateWithAttributedString(attString)
        let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attString.length), path, nil)
        rectFrame = frame
        CTFrameDraw(frame, context!)
    }
    
    @objc public func setText(_ textString: NSMutableAttributedString) {
        attString = textString
    }
    
    @objc public func tap(string: String, with Action: @escaping ()->()) {
        tapStringArray.append(string as NSString)
        reactFunctionArray.append(Action)
    }
    
    @objc public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject()
        var location = (touch as! UITouch).location(in: self)
        let lines = CTFrameGetLines(rectFrame!)
        let lineCounts = CFArrayGetCount(lines)
        var lineOrigins = [CGPoint](repeating: CGPoint.zero, count: lineCounts)
        CTFrameGetLineOrigins(rectFrame!, CFRangeMake(0, 0), &lineOrigins)
        var line: CTLine?
        var lineOrigin = CGPoint.zero
        for j in 0...(lineCounts - 1) {
            let origin = lineOrigins[j]
            let path = CTFrameGetPath(rectFrame!)
            let rect = path.boundingBox
            let y = rect.origin.y + rect.size.height - origin.y
            if ((location.y <= y) && (location.x >= (origin.x))) {
                line = unsafeBitCast( CFArrayGetValueAtIndex(lines, j) , to: CTLine.self)
                lineOrigin = origin
                break
            }
        }
        guard line != nil else {
            return
        }
        location.x = location.x - lineOrigin.x
        let index = CTLineGetStringIndexForPosition(line!, location)
        if let start = startIndex,let end = endIndex {
            if (CFIndex(start as String)! <= index && CFIndex(end as String)! >= index) {
                reactfunc()
            }
        }
        for tapString: NSString in tapStringArray {
            let range = (attString.string as NSString).range(of: tapString as String)
            if range.length > 0 {
                if index >= CFIndex(range.location) && index <= CFIndex(range.location + range.length) {
                    let stringIndex = tapStringArray.firstIndex(of: tapString)
                    let reactfunc:()->() = (reactFunctionArray as NSArray).object(at: stringIndex!) as! () -> ()
                    reactfunc()
                }
            }
        }
    }
}
