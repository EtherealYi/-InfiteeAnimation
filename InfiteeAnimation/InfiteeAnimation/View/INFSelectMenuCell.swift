//
//  INFSelectMenuCell.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/12.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFSelectMenuCell: UITableViewCell {

    var menuLabel: UILabel!
    var menuModel: INFMenuModel?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        menuLabel = UILabel()
        menuLabel.font = UIFont.systemFont(ofSize: 13)
        menuLabel.textAlignment = .center
        addSubview(menuLabel)
    }
    
    func setupData(model: INFMenuModel) -> Void {
        menuModel = model
        menuLabel.text = model.menuName
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        menuLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = -self.width
        animation.toValue = self.width/2
        
        let alphaAnimation = CABasicAnimation()
        alphaAnimation.keyPath = "alpha"
        alphaAnimation.fromValue = 0
        alphaAnimation.toValue = 1

        
        let group = CAAnimationGroup()
        group.animations = [animation, alphaAnimation]
        group.duration = menuModel!.delayTime
        group.fillMode = .forwards
        group.isRemovedOnCompletion = false
        menuLabel.layer.add(group, forKey: "")
        
        
    }
}
