//
//  INFThemeCell.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/2.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFThemeCell: UICollectionViewCell {
    
    public var backImageView: UIImageView!
    public var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backImageView = UIImageView()
        backImageView.contentMode = .scaleToFill
        contentView.addSubview(backImageView)
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
