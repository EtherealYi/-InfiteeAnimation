//
//  INFProductInfoCell.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/4.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFProductInfoCell: UITableViewCell {

   
    var titleLabel: UILabel!
    var infoLabel: UILabel!
    var tipsLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel()
        titleLabel.text = "尺码"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(16)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        infoLabel = UILabel()
        infoLabel.font = UIFont.systemFont(ofSize: 13)
        infoLabel.textColor = UIColor.lightGray
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right).offset(10)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
        }
        
        tipsLabel = UILabel()
        tipsLabel.font = UIFont.systemFont(ofSize: 13)
        tipsLabel.text = "尺码信息"
        tipsLabel.textColor = UIColor.gray
        contentView.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.infoLabel.snp.right).offset(10)
            make.centerY.equalTo(self.infoLabel.snp.centerY)
        }
    }
    
    func setupText(text: String) -> Void {
        if text.count > 0 {
            self.setNeedsLayout()
            self.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 0.2) {
                self.infoLabel.text = text
                self.updateConstraints()
                self.layoutIfNeeded()
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
