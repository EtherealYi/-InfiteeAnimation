//
//  INFSelectMenuTableViewController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/6.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

protocol INFSelectMenuTableViewControllerDelgate: NSObjectProtocol {
    func menuVCselectAtIndex(index: Int) -> Void
}

class INFSelectMenuTableViewController: INFBaseViewController, UITableViewDelegate, UITableViewDataSource {

    let cellID = "cellID"
    let menuCellID = "menuCellID"
    var tableView: UITableView!
    var dataArray: [INFMenuModel] = []
    var boolArrays: [Bool] = []
    var lineView: UIView!
    let cellHeight: CGFloat = 60
    weak var delegate: INFSelectMenuTableViewControllerDelgate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    public func setupData(menuArray: [INFMenuModel]) -> Void {
        dataArray = menuArray
        
        for _ in 0...dataArray.count {
            boolArrays.append(false)
        }
        tableView.reloadData()
    }
    
    func setupUI() -> Void {
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = cellHeight
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(INFSelectMenuCell.self, forCellReuseIdentifier: menuCellID)
        
        lineView = UIView()
        lineView.backgroundColor = UIColor.blue
        lineView.layer.cornerRadius = 2
        lineView.layer.masksToBounds = true
        view.addSubview(lineView)
        
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(0)
            make.width.equalTo(3)
            make.right.equalTo(view)
            make.top.equalTo(self.view.snp.top).offset(-cellHeight)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.lineView.height = self.cellHeight
            self.lineView.top = 44
        }) { (_) in
            
        }
        
    }
    
    public func scrollToSection(index: Int) -> Void {
        let cellIndexPath = IndexPath(row: index, section: 0)
        tableView.scrollToRow(at: cellIndexPath, at: .top, animated: true)
    }
    
}


extension INFSelectMenuTableViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuCellID) as! INFSelectMenuCell
        dataArray[indexPath.row].delayTime += (0.7 + 0.05 * Double(indexPath.row))
        cell.setupData(model: dataArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !boolArrays[indexPath.row] {
//            cell.transform = CGAffineTransform(translationX: view.width, y: 0)
//            cell.alpha = 0
//            let delayTime = 0.1 * Double(indexPath.row)
//
//            UIView.animate(withDuration: 0.4, delay: delayTime, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//                cell.alpha = 1
//                cell.transform = CGAffineTransform.identity
//            }) { (_) in
//                self.boolArrays[indexPath.row] = true
//            }
//            let animation = CABasicAnimation()
//            animation.keyPath = ""
//            animation.duration = 0.6
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) {
            let rect = cell.convert(cell.bounds, to: self.view)
            print("rect = \(rect)")
            UIView.animate(withDuration: 0.3) {
                self.lineView.top = rect.origin.y
            }
            
            if self.delegate != nil {
                self.delegate?.menuVCselectAtIndex(index: indexPath.row)
            }
        }
        
        
    }
    
}
