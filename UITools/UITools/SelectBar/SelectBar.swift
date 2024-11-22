//
//  SelectBar.swift
//  UITools
//
//  Created by zhoufei on 2024/11/21.
//

import UIKit

class SelectBar: UIView {
    
    @IBOutlet weak var leftRedNumLabel: UILabel!
    @IBOutlet weak var leftBottomState: UIView!
    
    @IBOutlet weak var rightRedNumLabel: UILabel!
    @IBOutlet weak var rightBottomState: UIView!
    
    var selectIndex: Int = 0 {
        willSet {
            selectItem(index: newValue)
        }
    }
    var selectBarSelectBlock: ((_ index: Int) -> ())?
    
    
    // MARK: - Life Cycle
    class func selectBar() -> SelectBar {
       return Bundle.main.loadNibNamed("SelectBar", owner: nil)?.first as! SelectBar
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        configRedNum(leftNum: 0, rightNum: 0)
    }
    
    
    // MARK: - Private Method
    func setupUI() {
        roundRedNumLabel(redNumLabel: leftRedNumLabel)
        roundRedNumLabel(redNumLabel: rightRedNumLabel)
    }
    
    func roundRedNumLabel(redNumLabel: UILabel) {
        redNumLabel.layer.cornerRadius = 5
        redNumLabel.layer.masksToBounds = true
    }
    
    func selectItem(index: Int) {
        switch index {
        case 0:
            leftBottomState.backgroundColor = UIColor.blue
            rightBottomState.backgroundColor = UIColor.clear
        case 1:
            leftBottomState.backgroundColor = UIColor.clear
            rightBottomState.backgroundColor = UIColor.blue
        default:
            break
        }
        
        
    }
    // MARK: - Public Method
    func configRedNum(leftNum: Int, rightNum: Int) {
        if leftNum > 0 {
            leftRedNumLabel.isHidden = false
            leftRedNumLabel.text = "+\(leftNum < 100 ? leftNum : 99)"
        } else {
            leftRedNumLabel.isHidden = true
        }
        
        if rightNum > 0 {
            rightRedNumLabel.isHidden = false
            rightRedNumLabel.text = "+\(rightNum < 100 ? rightNum : 99)"
        } else {
            rightRedNumLabel.isHidden = true
        }
    }
    
    // MARK: - Event
    
    @IBAction func leftBtnAction(_ sender: Any) {
        selectIndex = 0
        if let selectBarSelectBlockSub = selectBarSelectBlock {
            selectBarSelectBlockSub(selectIndex)
        }
    }
    
    @IBAction func rightBtnAction(_ sender: Any) {
        selectIndex = 1
        if let selectBarSelectBlockSub = selectBarSelectBlock {
            selectBarSelectBlockSub(selectIndex)
        }
    }
    
    
    // MARK: - Delegate
    
    // MARK: - Getter, Setter
    
    // MARK: - NSCopying
    
    // MARK: - NSObject
    
    // MARK: - Extension
}
