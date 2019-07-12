//
//  INFProductInfoViewController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/3.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFProductInfoViewController: INFImageViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellID = "cellID"
    let imageCellID = "imageCellID"
    let labelCellID = "labelCellID"
    var labelText: String = ""
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "产品详情"
        setupUI()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.labelText = "16.6 寸"
            self.tableView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
   
    func setupUI() -> Void {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(INFProductThemeImageCell.self, forCellReuseIdentifier: imageCellID)
        tableView.register(INFProductInfoCell.self, forCellReuseIdentifier: labelCellID)
        
    }
    
    override func setImage(image: UIImage) {
        super.setImage(image: image)
        tableView.reloadData()
    }

}

extension INFProductInfoViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: imageCellID) as! INFProductThemeImageCell
            cell.backImageView.image = self.transitionImage
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: labelCellID) as! INFProductInfoCell
            cell.setupText(text: labelText)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return kProductImageHeight
        default:
            return 50
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
