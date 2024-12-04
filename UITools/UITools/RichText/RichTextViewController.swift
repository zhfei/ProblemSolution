//
//  RichTextViewController.swift
//  UITools
//
//  Created by zhoufei on 2024/11/27.
//

import UIKit

class RichTextViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    class func richTextViewController() -> RichTextViewController {
        return RichTextViewController(nibName: "RichTextViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.attributedText = RichTextTool.createAttributedStringOnImage(with: "Hello World")
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
