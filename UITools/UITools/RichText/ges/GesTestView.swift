//
//  GesTestView.swift
//  UITools
//
//  Created by zhoufei on 2024/12/4.
//

import UIKit

class GesTestView: UIView {
    
    class func gesTestView() -> GesTestView {
       return Bundle.main.loadNibNamed("GesTestView", owner: nil)?.first as! GesTestView
    }

    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        print(sender)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
