//
//  INFSelectMenuViewController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/6.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFSelectMenuViewController: INFBaseViewController, INFSelectMenuTableViewControllerDelgate, INFMenuProductControllerDelegate, CAAnimationDelegate {

    
    var menuViewController: INFSelectMenuTableViewController!
    var productViewController: INFMenuProductController!
    private var closeButton: UIButton!
    private var menuArray: [INFMenuModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuArray.append(INFMenuModel(menu: "抱枕"))
        menuArray.append(INFMenuModel(menu: "帆布包"))
        menuArray.append(INFMenuModel(menu: "纯棉T"))
        menuArray.append(INFMenuModel(menu: "精棉T"))
        menuArray.append(INFMenuModel(menu: "运动裤"))
        menuArray.append(INFMenuModel(menu: "长款T"))
        menuArray.append(INFMenuModel(menu: "连帽灰裙"))
        menuArray.append(INFMenuModel(menu: "长袖帽衫"))
        menuArray.append(INFMenuModel(menu: "BB围兜"))
        menuArray.append(INFMenuModel(menu: "韩版宽松T"))
        menuArray.append(INFMenuModel(menu: "马丁"))
        menuArray.append(INFMenuModel(menu: "抱枕-2"))
        menuArray.append(INFMenuModel(menu: "帆布包-2"))
        menuArray.append(INFMenuModel(menu: "纯棉T-2"))
        menuArray.append(INFMenuModel(menu: "精棉T-2"))
        menuArray.append(INFMenuModel(menu: "运动裤-2"))
        menuArray.append(INFMenuModel(menu: "长款T-2"))
        menuArray.append(INFMenuModel(menu: "连帽灰裙-2"))
        menuArray.append(INFMenuModel(menu: "长袖帽衫-2"))
        menuArray.append(INFMenuModel(menu: "BB围兜-2"))
        menuArray.append(INFMenuModel(menu: "韩版宽松T-2"))
        menuArray.append(INFMenuModel(menu: "马丁-2"))
        
        
        menuViewController = INFSelectMenuTableViewController()
        menuViewController.delegate = self
        
        addChild(menuViewController)
        view.addSubview(menuViewController.view)
        
        productViewController = INFMenuProductController()
        productViewController.delegate = self
        addChild(productViewController)
        view.addSubview(productViewController.view)
        
        closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "menuClose"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonClick(sender:)), for: .touchUpInside)
        view.addSubview(closeButton)
        
        self.menuViewController.view.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(view)
            make.width.equalTo(80)
            
        }
        
        productViewController.view.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(view)
            make.left.equalTo(menuViewController.view.snp.right)
        }
        
        self.closeButton.snp.makeConstraints { (make) in
//            make.bottom.equalTo(self.view.snp.bottom).offset(-40)
            make.bottom.equalTo(view.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.left).offset(40)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
      
        menuViewController.setupData(menuArray: menuArray)
        productViewController.setupData(menuArray: menuArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closeButtonAnimation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
       
    }

    @objc func closeButtonClick(sender: UIButton) -> Void {
        self.dismiss(animated: true) {
            
        }
    }
}

extension INFSelectMenuViewController {
 
    private func closeButtonAnimation() -> Void {
        let animation = CASpringAnimation()
        animation.delegate = self
        animation.duration = 1
//        animation.keyPath = "transform.scale"
        animation.keyPath = "position.y"
        animation.fromValue = view.height
        animation.toValue = view.height - 60
//        animation.fromValue = 0
//        animation.toValue = 1
        animation.mass = 2
        animation.stiffness = 60
        animation.damping = 9
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        closeButton.layer.add(animation, forKey: "close_animation")
        
    }
    
    func menuVCselectAtIndex(index: Int) {
        productViewController.scrollToSection(index: index)
    }
    
    func productVCselectAtIndex(index: Int) {
        menuViewController.scrollToSection(index: index)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.closeButton.snp.updateConstraints { (make) in
                make.bottom.equalTo(self.view.snp.bottom).offset(-40)
            }
        }
    }
}
