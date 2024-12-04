//
//  RichTextTool.swift
//  UITools
//
//  Created by zhoufei on 2024/11/27.
//

import UIKit

class RichTextTool: NSObject {
    //图片在字符串的左部
    class func createAttributedStringAppendImage(with text: String) -> NSAttributedString {
        // 创建背景图像
        let backgroundSize = CGSize(width: 200, height: 50) // 根据文本的大小调整背景大小
        
        UIGraphicsBeginImageContextWithOptions(backgroundSize, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        // 设置圆角矩形
        let rect = CGRect(x: 0, y: 0, width: backgroundSize.width, height: backgroundSize.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        
        // 填充背景颜色
        context?.addPath(path.cgPath)
        context?.setFillColor(UIColor.orange.cgColor)
        context?.fillPath()

        // 获取背景图像
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // 创建 NSTextAttachment
        let attachment = NSTextAttachment()
        attachment.image = backgroundImage
        
        // 创建富文本字符串
        let attributedString = NSMutableAttributedString(attachment: attachment)
        
        // 创建文本的富文本
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.blue
        ]
        let textAttributedString = NSAttributedString(string: text, attributes: textAttributes)
        
        // 将文本添加到富文本
        attributedString.append(textAttributedString)
        
        return attributedString
    }
    
    // 图片在文本的底部
    class func createAttributedStringOnImage(with text: String) -> NSAttributedString {
        // 创建 NSTextAttachment
        let attachment = NSTextAttachment()
        attachment.image = createImage()
        
        // 3.当作附件添加到富文本中
        let attributedString = NSMutableAttributedString(attachment: attachment)
        return attributedString
    }
    
    class func createImage() -> UIImage? {
        //1.创建视图
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        containerView.backgroundColor = .brown
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        title.text = "hello world"
        title.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        title.textColor = .red
        title.textAlignment = .center
        containerView.addSubview(title)
        
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
        //2.把视图渲染成图片
        var iconImage: UIImage?
        UIGraphicsBeginImageContextWithOptions(containerView.bounds.size, false, UIScreen.main.scale)
        if let currentContext = UIGraphicsGetCurrentContext() {
            containerView.layer.render(in: currentContext)
            iconImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
        return iconImage
    }

}
