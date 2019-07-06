//
//  INFProductThemeImageCell.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/3.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFProductThemeImageCell: UITableViewCell {
    
    var backImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backImageView = UIImageView()
        self.contentView.addSubview(self.backImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
