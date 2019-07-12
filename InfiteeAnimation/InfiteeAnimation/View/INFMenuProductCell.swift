//
//  INFMenuProductCell.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/10.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFMenuProductCell: UICollectionViewCell {
    
    @IBOutlet weak var madeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        madeButton.layer.cornerRadius = 13
        madeButton.layer.masksToBounds = true
        
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
     
    }
}
