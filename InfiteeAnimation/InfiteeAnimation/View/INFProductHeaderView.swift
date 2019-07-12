//
//  INFProductHeaderView.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/10.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFProductHeaderView: UICollectionReusableView {
    
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() -> Void {
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        addSubview(titleLabel)
        
        subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        subTitleLabel.textColor = UIColor.gray
        subTitleLabel.text = "产品介绍"
        addSubview(subTitleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(15)
            make.centerY.equalTo(self)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-15)
            make.centerY.equalTo(self)
        }
    }
}
