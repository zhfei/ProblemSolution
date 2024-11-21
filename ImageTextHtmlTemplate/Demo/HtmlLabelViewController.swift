//
//  HtmlLabelViewController.swift
//  ImageTextHtmlTemplate
//
//  Created by zhoufei on 2024/11/15.
//

import UIKit
import YYText_swift
import SnapKit

class HtmlLabelViewController: UIViewController {
    
    lazy var yylabel: YYLabel = {
        let yy = YYLabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        yy.numberOfLines = 0
        return yy
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    
    // MARK: - Private Method
    func setupUI() {
        view.addSubview(yylabel)
        yylabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
//        yylabel.yy_setHtmlAttributedString(text: "<p>提名：<span>@老福特</span><i>这里<i/></p>", font: UIFont.systemFont(ofSize: 20), lineSpacing: 20)
        
        let htmlStr = """
            <p style="color: rgb(46, 46, 46);font-size: 20px;" >提名：<span style="color: rgb(99, 193, 187);font-size: 20px;">@老福特</span></p>
            <p style="color: rgb(46, 46, 46);font-size: 20px;" >印象词：
              <span style="color: rgb(236,151,80);font-size: 20px;border-radius: 10px;background-color: rgb(253    246    233    ); padding: 4px 8px; margin-right: 5px;">高产如牛</span>
              <span style="color: rgb(236,151,80);font-size: 20px;border-radius: 10px;background-color: rgb(253    246    233    ); padding: 4px 8px;">最好的厨子</span>
            </p>
            <p style="color: rgb(46, 46, 46);font-size: 20px;" >提名：
              <span>这个老师的作品就是仙品 </span>
            </p>
        """
//        if let htmlData = htmlStr.data(using: .unicode) {
//            let attriM = try? NSMutableAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
//            yylabel.attributedText = attriM
            
            yylabel.yy_setHtmlAttributedString(text: htmlStr, font: UIFont.systemFont(ofSize: 20), lineSpacing: 20)

//        }
        
    }
    
    // MARK: - Public Method
    
    // MARK: - Event
    
    // MARK: - Delegate
    
    // MARK: - Getter, Setter
    
    // MARK: - NSCopying
    
    // MARK: - NSObject
    
    // MARK: - Extension

}
