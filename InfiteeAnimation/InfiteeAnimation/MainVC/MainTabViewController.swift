//
//  MainTabViewController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/6/27.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class MainTabViewController: ESTabBarController, UITabBarControllerDelegate, CAAnimationDelegate, INFAddSelectMenuViewDelegate{

    var addButton: UIButton!
    var isRotate: Bool = false
    var isShow: Bool = false
    var maskView: UIVisualEffectView!
    var menuView: INFAddSelectMenuView!
    var centerImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(hiddTarBarBottom(notification:)), name: Notification.Name(rawValue: kNotificationHiddenBarBottom), object: nil)
        setupUI()
        
        shouldHijackHandler = { tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        self.didHijackHandler = {
            [weak self] tabbarController, viewController, index in
            
//            self?.centerImageViewClick(sender: (self?.centerImageView)!)
            self?.addButtonClick(sender: self!.addButton)
        }
        
        let homeVc = ViewController()
        let nav = INFNavigationController(rootViewController: homeVc)
        addChildController(vc: nav, title: "首页", imageName: "home", selectImage: "home_select", isCenter: false, tag: 0)
        
        let addVc = INFBaseViewController()
//        addChildController(vc: addNav, title: "", imageName: "addButton", selectImage: nil, isCenter: true, tag: 1)
        addChildController(vc: addVc, title: "", imageName: nil, selectImage: nil, isCenter: false, tag: 1)
        
        let myVC = INFMineViewController()
        let myNav = INFNavigationController(rootViewController: myVC)
        addChildController(vc: myNav, title: "个人中心", imageName: "personal", selectImage: "personal_select", isCenter: false, tag: 2)
        
        
    }
    
    func addChildController<T: UIViewController>(vc: T, title: String, imageName: String?, selectImage: String?,isCenter: Bool, tag: Int) -> Void {
     
        let contentView = ESTabBarItemContentView()
        
        vc.tabBarItem = ESTabBarItem.init(contentView, title: title, image: UIImage(named: imageName ?? ""), selectedImage: UIImage(named: selectImage ?? ""), tag: tag)
        
        if isCenter {
            centerImageView = contentView.imageView
            contentView.renderingMode = .alwaysOriginal
            contentView.itemContentMode = .alwaysOriginal
            contentView.imageView.sizeToFit()
            contentView.insets = UIEdgeInsets(top: -32, left: 0, bottom: 0, right: 0)
        }
        if tag == 0 {
            contentView.selected = true
        }
        self.addChild(vc)
    }
    
    func setupUI() -> Void {
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

        addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named: "addButton"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClick(sender:)), for: .touchUpInside)
        self.view.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.bottom.equalTo(view).offset(-32)
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
            make.bottom.equalTo(self.tabBar.snp.top).offset(-32)
        }
        
    }
 
    
    //MARK: INFAddSelectMenuViewDelegate
    func madeClick() {
        let vc = INFSelectMenuViewController()
        self.present(vc, animated: true) {
            
        }
        self.addButtonClick(sender: addButton)
    }
  
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension MainTabViewController {
    
    @objc private func hiddTarBarBottom(notification: Notification) -> Void {
        if let dict: Dictionary = notification.object as? [String:String] {
            let operantion = dict["operation"]
            if operantion == "fromBottom" {
                if addButton.width <= 0 || addButton.height <= 0 {
                    return
                }
                let positionAnim = CABasicAnimation(keyPath: "position.y")
                positionAnim.duration = 0.4
                positionAnim.fromValue = addButton.layer.position.y
                positionAnim.toValue = UIScreen.main.bounds.height + 30
                positionAnim.timingFunction =  CAMediaTimingFunction(name: .easeOut)
                positionAnim.fillMode = .forwards
                positionAnim.isRemovedOnCompletion = false
                addButton.layer.add(positionAnim, forKey: "fromBottom")
               
                
            }else if operantion == "fromTop" {
                if addButton.width < 0 || addButton.height < 0 {
                    return
                }
                let positionAnim = CABasicAnimation(keyPath: "position.y")
                positionAnim.duration = 0.4
                positionAnim.fromValue = UIScreen.main.bounds.height + 30
                positionAnim.toValue = UIScreen.main.bounds.height - 62
                positionAnim.timingFunction = CAMediaTimingFunction(name: .easeOut)
                positionAnim.fillMode = .forwards
                positionAnim.isRemovedOnCompletion = false
                addButton.layer.add(positionAnim, forKey: "fromTop")
            }
            
            
        }
    }
    
    //MARK: 按钮动画
    @objc func addButtonClick(sender: UIButton) -> Void {
        addButton.isUserInteractionEnabled = false
        let rotateAnimation = CABasicAnimation()
//        let rotateAnimation = CASpringAnimation()
        rotateAnimation.keyPath = "transform.rotation.z"
        rotateAnimation.delegate = self
        if isRotate {
            rotateAnimation.fromValue = Double.pi / 4
            rotateAnimation.toValue = 0
        }else{
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = Double.pi / 4
        }
        rotateAnimation.duration = 0.3
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotateAnimation.fillMode = .forwards
        rotateAnimation.isRemovedOnCompletion = false
        addButton.layer.add(rotateAnimation, forKey: "")
        
        isShow = !isShow
        showMaskView(isShow: isShow)
    }
    
    func showMaskView(isShow: Bool) -> Void {

        if isShow {
            maskView.isHidden = false
            menuView.isHidden = false
            self.menuView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }else{
            self.menuView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
    
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
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
