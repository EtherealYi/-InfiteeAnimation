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
    var dataArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray.append("系统消息")
        dataArray.append("用户小溪")
        title = "个人中心"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func setupUI() -> Void {
        tableView = UITableView(frame: .zero, style: .plain)
//        tableView.contentInset = UIEdgeInsets(top: -44, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        // headerView
        let headerView = INFMineHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.width))
        tableView.tableHeaderView = headerView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
         
        tableView.configRefreshHeader(container: self) { [weak self] in
            self?.dataArray.append("新增消息")
            self?.tableView.switchRefreshHeader(to: .normal(.success, 0.3))
            
            let visableCells: [UITableViewCell] = (self?.tableView.visibleCells)!
            for cell in visableCells {
                self?.disappearAnimation(cell: cell)
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self?.tableView.reloadData()
            })
        }
        
        
        tableView.register(UINib(nibName: "INFMineMessageCell", bundle: nil), forCellReuseIdentifier: messageCellID)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageCellID) as! INFMineMessageCell
        cell.selectionStyle = .none
        cell.headerLabel.text = dataArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cellAnimation(cell: cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transiAmitor = INFFrameAnimator()
        transiAmitor.duration = 0.5
        let vc = INFBaseViewController()
        vc.view.backgroundColor = UIColor.red
        vc.hidesBottomBarWhenPushed = true
        self.animtorNavigationController?.pushToVC(viewControllrt: vc, animator: transiAmitor)

    }
}

extension INFMineViewController {
    
    private func disappearAnimation(cell: UITableViewCell) -> Void{
        let disapearAnim = CABasicAnimation(keyPath: "opacity")
        disapearAnim.duration = 0.3
        disapearAnim.fromValue = 1
        disapearAnim.toValue = 0
        disapearAnim.fillMode = .forwards
        disapearAnim.isRemovedOnCompletion = false
        cell.layer.add(disapearAnim, forKey: "cell_disappear")
    }
    
    private func cellAnimation(cell: UITableViewCell) -> Void {
        
        
        let animation = CASpringAnimation()
        animation.keyPath = "position.y"
        animation.fromValue = UIScreen.main.bounds.height
        animation.toValue = cell.center.y
        // 质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
        animation.mass = 1
        // 刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
        animation.stiffness = 60
        // 阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
        animation.damping = 10
        // 初始速率
        animation.initialVelocity = 0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        let alphaAni = CABasicAnimation()
        alphaAni.keyPath = "opacity"
        alphaAni.fromValue = 0
        alphaAni.toValue = 1
        
        let group = CAAnimationGroup()
        group.animations = [animation, alphaAni]
        group.duration = animation.settlingDuration
        group.fillMode = .forwards
        group.isRemovedOnCompletion = false
        cell.layer.add(group, forKey: "cell_reload")
    }
}
