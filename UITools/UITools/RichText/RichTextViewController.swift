//
//  RichTextViewController.swift
//  UITools
//
//  Created by zhoufei on 2024/11/27.
//

import UIKit
import SnapKit

class RichTextViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    class func richTextViewController() -> RichTextViewController {
        return RichTextViewController(nibName: "RichTextViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.attributedText = RichTextTool.createAttributedStringOnImage(with: "Hello World")
        
        let ges = GesTestView.gesTestView()
        self.view.addSubview(ges)
        ges.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 50))
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(60)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
