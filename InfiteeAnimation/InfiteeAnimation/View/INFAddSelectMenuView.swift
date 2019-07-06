//
//  INFAddSelectMenuView.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/5.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFAddSelectMenuView: UIView {

    var madeButton: UIButton!
    var saleButton: UIButton!
    var line: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        madeButton = UIButton(type: .custom)
        madeButton.setTitle("我要定制\n购买属于自已的产品", for: .normal)
        madeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        madeButton.titleLabel?.numberOfLines = 0
        madeButton.setTitleColor(UIColor.blue, for: .normal)
        madeButton.titleLabel?.textAlignment = .center
        addSubview(madeButton)
        
        saleButton = UIButton(type: .custom)
        saleButton.setTitle("我要出售\n出售我的作品获取收益", for: .normal)
        saleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        saleButton.titleLabel?.numberOfLines = 0
        saleButton.setTitleColor(UIColor.red, for: .normal)
        saleButton.titleLabel?.textAlignment = .center
        addSubview(saleButton)
        
        line = UIView()
        line.backgroundColor = UIColor.groupTableViewBackground
        addSubview(line)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        madeButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(self.saleButton.snp.left)
            make.width.equalTo(self.saleButton.snp.width)
        }
        
        saleButton.snp.makeConstraints { (make) in
            make.left.equalTo(madeButton.snp.right)
            make.top.right.bottom.equalTo(self)
            make.width.equalTo(self.madeButton.snp.width)
        }
        
        line.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(1)
            make.top.equalTo(self.snp.top).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
