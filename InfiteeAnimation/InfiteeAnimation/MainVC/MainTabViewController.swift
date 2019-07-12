//
//  MainTabViewController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/6/27.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController, UITabBarControllerDelegate, CAAnimationDelegate, INFAddSelectMenuViewDelegate{

    var addButton: UIButton!
    var isRotate: Bool = false
    var isShow: Bool = false
    var maskView: UIVisualEffectView!
    var menuView: INFAddSelectMenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let homeVc = ViewController()
        let nav = INFNavigationController(rootViewController: homeVc)
        self.addChildController(vc: nav, title: "首页")
        
        let addVc = INFBaseViewController()
        let addNav = INFNavigationController(rootViewController: addVc)
        addChildController(vc: addNav, title: "")
        
        let myVC = UIViewController()
        let myNav = INFNavigationController(rootViewController: myVC)
        addChildController(vc: myNav, title: "个人中心")
        
        setupAddButton()
    }
    
    func addChildController<T: UIViewController>(vc: T, title: String) -> Void {
        vc.tabBarItem.title = title
        self.addChild(vc)
    }
    
    func setupAddButton() -> Void {
        // 蒙版View
//        let window = UIApplication.shared.keyWindow
        let blurEffect = UIBlurEffect(style: .extraLight)
        maskView = UIVisualEffectView(effect: blurEffect)
        maskView.isHidden = true
        maskView.alpha = 0
        self.view.addSubview(maskView)
        maskView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        // 中间按钮
        addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named: "addButton"), for: .normal)
        addButton.setImage(UIImage(named: "addButton"), for: .highlighted)
        addButton.addTarget(self, action: #selector(addButtonClick(sender:)), for: .touchUpInside)
        self.view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.tabBar.snp.centerX)
            make.top.equalTo(self.tabBar.snp.top).offset(-5)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        menuView = Bundle.main.loadNibNamed("INFAddSelectMenuView", owner: nil, options: nil)?.first as? INFAddSelectMenuView
        menuView.isHidden = true
        menuView.alpha = 0
        menuView.layer.cornerRadius = 6
        menuView.layer.masksToBounds = true
        menuView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.6)
        menuView.delegate = self
        self.view.addSubview(menuView)
        menuView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalTo(300)
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(addButton.snp.top).offset(-20)
        }
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return !(viewController == tabBarController.viewControllers![1])
    }
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
//        return DCSlideBarAnimation() //滑动动画
        return nil
    }
    
    //MARK: INFAddSelectMenuViewDelegate
    func madeClick() {
        let vc = INFSelectMenuViewController()
        self.present(vc, animated: true) {
            
        }
        self.addButtonClick(sender: self.addButton)
    }
  
}

extension MainTabViewController {
    @objc func addButtonClick(sender: UIButton) -> Void {
        addButton.isUserInteractionEnabled = false
        let rotateAnimation = CABasicAnimation()
        rotateAnimation.keyPath = "transform.rotation.z"
        rotateAnimation.delegate = self
        if isRotate {
            rotateAnimation.fromValue = Double.pi / 4
            rotateAnimation.toValue = 0
        }else{
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = Double.pi / 4
        }
        isShow = !isShow
        showMaskView(isShow: isShow)
        rotateAnimation.duration = 0.4
        rotateAnimation.fillMode = .forwards
        rotateAnimation.isRemovedOnCompletion = false
        
        addButton.layer.add(rotateAnimation, forKey: "")
        
        
    }
    
    func showMaskView(isShow: Bool) -> Void {

        if isShow {
            maskView.isHidden = false
            menuView.isHidden = false
            self.menuView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }else{
            self.menuView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        
        UIView.animate(withDuration: 0.4, animations: {
            self.maskView.alpha = isShow ? 1 : 0
            self.menuView.alpha = isShow ? 1 : 0
            if isShow {
               self.menuView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }else{
                self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }
            
        }) { (_) in
            if !isShow {
                self.maskView.isHidden = true
                self.menuView.isHidden = true
            }
        }
    }
    
    //MARK: CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            addButton.isUserInteractionEnabled = true
            isRotate = !isRotate
        }
        
    }
}
