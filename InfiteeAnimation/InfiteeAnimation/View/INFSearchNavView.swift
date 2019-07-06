//
//  INFSearchNavView.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/6/27.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

protocol INFSearchNavViewDelegate: NSObjectProtocol {
    
    func searchBarDidBegin() -> Void
    func searchBarDidEnd() -> Void
    
}

class INFSearchNavView: UIView, UITextFieldDelegate, CAAnimationDelegate {


    private var searchBar: UIView!
    private var buyBarButton: UIButton!
    private var searchButton: UIButton!
    private var searchTextField: UITextField!
    private var closeButton: UIButton!
    
    weak open var delegate: INFSearchNavViewDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        searchBar = UIView()
        searchBar.layer.cornerRadius = 13
        searchBar.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.layer.borderWidth = 0.8
        self.addSubview(self.searchBar)
        
        buyBarButton = UIButton(type: .custom)
        buyBarButton.setImage(UIImage(named: "buycar"), for: .normal)
        self.addSubview(buyBarButton)
        
        searchTextField = UITextField()
        searchTextField.placeholder = "搜索"
        searchTextField.font = UIFont.systemFont(ofSize: 12)
        searchTextField.delegate = self
        self.addSubview(searchTextField)
        
        searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        self.addSubview(searchButton)
        
        closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeClick(sender:)), for: .touchUpInside)
        self.addSubview(closeButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        searchBar.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-16)
            make.top.equalTo(self.snp.top).offset(8)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
            make.left.equalTo(self.snp.left).offset(200)
        }
        
        buyBarButton.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(searchBar)
            make.width.equalTo(40)
        }

        searchButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(buyBarButton)
            make.right.equalTo(buyBarButton.snp.left)
            make.width.equalTo(buyBarButton.snp.width)
        }
//
        searchTextField.snp.makeConstraints { (make) in
            make.left.equalTo(searchBar).offset(16)
            make.top.bottom.equalTo(searchBar)
            make.right.equalTo(searchButton.snp.left)
//            make.width.equalTo(100)
        }

        closeButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self.snp.right).offset(16)
        }
    }
    
    //MARK: 动画
    func startAnimation() -> Void {
        let positAnimation = CABasicAnimation()
        positAnimation.keyPath = "position"
        positAnimation.fromValue = closeButton.center
        let centerX = self.frame.size.width - 25
        let toPoint = CGPoint(x: centerX, y: closeButton.center.y)
        positAnimation.toValue = toPoint
        
        positAnimation.fillMode = .forwards
        positAnimation.isRemovedOnCompletion = false
        
        let rotationAnimation = CABasicAnimation()
        rotationAnimation.keyPath = "transform.rotation.z"
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi
        rotationAnimation.fillMode = .forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positAnimation, rotationAnimation]
        groupAnimation.delegate = self
        groupAnimation.duration = 0.4
        groupAnimation.fillMode = .forwards
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.setValue(toPoint, forKey: "posit")
        closeButton.layer.add(groupAnimation, forKey: nil)
        
    }
    
    func stopAnimation() -> Void {
        let positionAnimation = CABasicAnimation()
        positionAnimation.keyPath = "position"
        positionAnimation.delegate = self
        positionAnimation.fromValue = NSValue(cgPoint: CGPoint(x: self.frame.size.width-25, y: self.center.y))
        let centerX = self.frame.size.width + 25
        positionAnimation.toValue = NSValue(cgPoint: CGPoint(x: centerX, y: closeButton.center.y))
        
        positionAnimation.duration = 0.4
        positionAnimation.fillMode = .forwards
        positionAnimation.isRemovedOnCompletion = false
        
        let rotationAnimation = CABasicAnimation()
        rotationAnimation.keyPath = "transform.rotation.z"
        rotationAnimation.fromValue = NSNumber(value: 0)
        rotationAnimation.toValue = NSNumber(value: Double.pi)
        rotationAnimation.duration = 0.4
        rotationAnimation.fillMode = .forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, rotationAnimation];
        groupAnimation.delegate = self
        groupAnimation.duration = 0.4;
        groupAnimation.fillMode = .forwards;
        groupAnimation.isRemovedOnCompletion = false;
        closeButton.layer.add(groupAnimation, forKey: nil)
    }
    
    //MARK: UIEvent
    @objc func closeClick(sender: UIButton) -> Void {
        
        stopAnimation()
    }
}

extension INFSearchNavView {
   
    //MARK: 开始动画
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        textField.becomeFirstResponder()
        self.setNeedsUpdateConstraints()
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.searchBar.snp.updateConstraints({ (make) in
                make.left.equalTo(self.snp.left).offset(16)
                make.right.equalTo(self.snp.right).offset(-40)
//                make.top.equalTo(self.snp.top).offset(8)
//                make.bottom.equalTo(self.snp.bottom).offset(-8)
                make.top.equalTo(self.snp.top)
                make.bottom.equalTo(self.snp.bottom)
                
            })
            self.searchBar.layer.cornerRadius = 18
            self.updateConstraintsIfNeeded()
            self.layoutIfNeeded()
        }) { (_) in
            
        }
        startAnimation()
        
        if self.delegate != nil {
            self.delegate?.searchBarDidBegin()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.setNeedsUpdateConstraints()
        self.setNeedsLayout()
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {

            self.searchBar.snp.remakeConstraints({ (make) in
                make.right.equalTo(self.snp.right).offset(-16);
                make.top.equalTo(self.snp.top).offset(8)
                make.bottom.equalTo(self.snp.bottom).offset(-8)
                make.left.equalTo(self.snp.left).offset(200)
            })
            self.searchBar.layer.cornerRadius = 14
            self.updateConstraintsIfNeeded()
            self.layoutIfNeeded()
        }) { (_) in
            
        }
        stopAnimation()
        
        if self.delegate != nil {
            self.delegate?.searchBarDidEnd()
        }
        
        return true
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
//        if flag {
//            CATransaction.begin()
//            CATransaction.setDisableActions(true)
//            if let position = anim.value(forKey: "posit") as? CGPoint {
//                closeButton.layer.position = position
//            }
//            CATransaction.commit()
//        }
    }
}
