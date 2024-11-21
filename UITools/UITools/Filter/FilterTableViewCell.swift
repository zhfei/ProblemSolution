//
//  FilterTableViewCell.swift
//  UITools
//
//  Created by zhoufei on 2024/11/21.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUI(data: FilterModel) {
        titleLabel.text = data.title
        if data.selected {
            flagImageView.image =  UIImage(systemName: "circle.fill")
        } else {
            flagImageView.image = nil
        }
        
    }
    
}
