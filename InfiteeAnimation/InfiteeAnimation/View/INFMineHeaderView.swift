//
//  INFMineHeaderView.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/15.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFMineHeaderView: UIView {

    var topView: UIView!
    var iconView: UIImageView!
    var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        backgroundColor = UIColor.white
        topView = UIView()
        topView.backgroundColor = UIColor.purple
        addSubview(topView)
        
        iconView = UIImageView(image: UIImage(named: "mine_icon"))
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        topView.addSubview(iconView)
        
        nameLabel = UILabel()
        nameLabel.text = "Master Yi"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        addSubview(nameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(22)
            make.right.bottom.equalTo(self)
            make.height.equalTo(60)
        }
        
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.bottom.equalTo(nameLabel.snp.top)
        }

        iconView.snp.makeConstraints { (make) in
            make.edges.equalTo(topView)
        }
    }
}
