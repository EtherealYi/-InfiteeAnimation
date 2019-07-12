//
//  INFAddSelectMenuView.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/5.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

protocol INFAddSelectMenuViewDelegate: NSObjectProtocol {
    func madeClick() -> Void
}

class INFAddSelectMenuView: UIView {
    
    @IBOutlet weak var medaView: UIView!
    
    weak open var delegate: INFAddSelectMenuViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(_medeViewClick(sender:)))
        medaView.isUserInteractionEnabled = true
        medaView.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        


    }
    
    @objc func _medeViewClick(sender: UIButton) -> Void {
    
        if (self.delegate != nil) {
            self.delegate?.madeClick()
        }
    }
    
}
