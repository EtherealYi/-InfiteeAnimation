//
//  INFThemeMadeView.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/2.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFThemeMadeView: UIView {

    @IBOutlet weak var confirmButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        confirmButton.layer.cornerRadius = 2
        confirmButton.layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
