//
//  INFPtoductCell.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/2.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFPtoductCell: UICollectionViewCell {
    
    var iconImgView: UIImageView!
    var titleLabel: UILabel!
    var detailLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() -> Void{
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = true;
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.shadowColor = UIColor.lightGray.cgColor
        self.contentView.layer.shadowOffset = CGSize.zero
        self.contentView.layer.shadowOpacity = 0.2
        
        self.iconImgView = UIImageView()
        
        self.contentView.addSubview(self.iconImgView)
    
        self.iconImgView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.contentView.snp.top).offset(5);
            make.left.equalTo(self.contentView.snp.left).offset(5);
            make.right.equalTo(self.contentView.snp.right).offset(-5);
            make.height.equalTo(self.iconImgView.snp.width);
        })
        
        self.titleLabel = UILabel();
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.titleLabel.text = "Product Jin";
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(8);
            make.top.equalTo(self.iconImgView.snp.bottom).offset(8);
        }
        
        self.detailLabel = UILabel();
        self.detailLabel.font = UIFont.systemFont(ofSize: 12)
        self.detailLabel.textColor = UIColor.lightGray
        self.detailLabel.text = "detail";
        self.contentView.addSubview(self.detailLabel)
        self.detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.left)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4);
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
