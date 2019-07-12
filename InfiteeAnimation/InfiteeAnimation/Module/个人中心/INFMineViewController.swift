//
//  INFMineViewController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/12.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit
import PullToRefreshKit

class INFMineViewController: INFBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    let messageCellID = "messageCellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人中心"
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func setupUI() -> Void {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.configRefreshHeader(container: self) { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                self?.tableView.switchRefreshHeader(to: .normal(.success, 0.3))
                self?.tableView.setNeedsLayout()
                self?.tableView.reloadData()
                self?.tableView.layoutIfNeeded()
            })
        }
        
        tableView.register(UINib(nibName: "INFMineMessageCell", bundle: nil), forCellReuseIdentifier: messageCellID)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellID) as! INFMineMessageCell
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let animation = CASpringAnimation()
        animation.keyPath = "position.y"
        animation.fromValue = 100
        animation.toValue = 0
        animation.mass = 1
        animation.stiffness = 100
        animation.damping = 10
        animation.initialVelocity = 0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        cell.layer.add(animation, forKey: "")
        
    }
}
