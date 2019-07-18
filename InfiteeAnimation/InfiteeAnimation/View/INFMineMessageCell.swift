//
//  INFMineMessageCell.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/12.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit



class INFMineMessageCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var reedButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        // Initialization code
        reedButton.layer.borderColor = UIColor.blue.cgColor
        reedButton.layer.borderWidth = 1
        reedButton.layer.cornerRadius = 2
        reedButton.layer.masksToBounds = true
        
        centerView.layer.borderWidth = 0.3
        centerView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func readButtonClick(_ sender: UIButton) {
    }
}
