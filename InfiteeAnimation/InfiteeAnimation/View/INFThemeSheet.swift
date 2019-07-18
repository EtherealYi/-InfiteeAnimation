//
//  INFThemeSheet.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/2.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFSnapView: UIView {
    var imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        imageView.autoresizesSubviews = true
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class INFThemeSheet: UIViewController {

    public var duration: Double = 1.0
    private var dampingRatio: CGFloat = 0.9
    private var contentView: UIView = UIView()
    private var effectView: UIVisualEffectView!
    private var snapView: INFSnapView?
    private var startRect: CGRect?
    private var fromView: UIView?
    private var madeView: INFThemeMadeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = view.bounds
        view.addSubview(effectView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(effectViewClick))
        effectView.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }
    
    
    class func sheetWithshotView(view: UIView) -> INFThemeSheet{
        
        let sheet = INFThemeSheet()
        sheet.modalTransitionStyle = .crossDissolve
        sheet.providesPresentationContextTransitionStyle = true
        sheet.definesPresentationContext = true
        sheet.modalPresentationStyle = .overCurrentContext
        sheet.setupView(sheetView: view)
        return sheet
    }

    func setupView(sheetView: UIView) -> Void {
        
        snapView = snapshotView(shotView: sheetView)
        
//        snapView?.backgroundColor = UIColor.red
        self.startRect = snapView?.frame
        
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.frame = startRect!
        
        snapView?.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        view.addSubview(contentView)
        contentView.addSubview(snapView!)
        
        contentView.autoresizesSubviews = true
        snapView?.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        

        madeView = Bundle.main.loadNibNamed("INFThemeMadeView", owner: nil, options: nil)?.first as? INFThemeMadeView
        

        madeView?.frame = CGRect(x: 0, y: -100, width: view.frame.size.width * 0.6, height: 370)
        madeView?.alpha = 0
        contentView.addSubview(madeView!)
    
        
    }
    
    
    @objc func effectViewClick() -> Void {
        closeAnimation()
    }
}

extension INFThemeSheet{
    
    func showSheet() -> Void {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        rootVC?.present(self, animated: true, completion: {
            
        })
    }
    //MARK: 开始动画
    func startAnimation() -> Void {
        fromView?.isHidden = true
        effectView.isUserInteractionEnabled = false
        let width = self.view.frame.size.width - 80
        let height = self.view.frame.size.height * 0.55
        self.view.setNeedsLayout()
        UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: dampingRatio, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {

            
            self.contentView.frame.size.width = width

            self.contentView.height = height
            self.contentView.center = self.view.center

            self.madeView?.frame.size.width = width
            self.madeView?.frame.size.height = height

            self.madeView?.center = CGPoint(x: width/2, y: height/2)

            self.snapView?.alpha = 0

            self.madeView?.alpha = 1
            self.view.layoutIfNeeded()
        }) { (_) in
            self.effectView.isUserInteractionEnabled = true
        }
        
//        let contentBoundsAnim = CASpringAnimation(keyPath: "bounds.size")
//        contentBoundsAnim.duration = self.duration
//        contentBoundsAnim.fromValue = contentView.layer.bounds.size
//        let width = self.view.frame.size.width - 80
//        let height = self.view.frame.size.height * 0.55
//        contentBoundsAnim.toValue = CGSize(width: width, height: height)
//        contentBoundsAnim.mass = 1
//        contentBoundsAnim.stiffness = 60
//        contentBoundsAnim.damping = 9
//
//        let contentPositionAnim = CASpringAnimation(keyPath: "position")
//        contentPositionAnim.fromValue = contentView.layer.position
//        contentPositionAnim.toValue = self.view.layer.position
//        contentPositionAnim.mass = 1
//        contentPositionAnim.stiffness = 60
//        contentPositionAnim.damping = 9
//
//        let group = CAAnimationGroup()
//        group.duration = self.duration
//        group.animations = [contentBoundsAnim, contentPositionAnim]
//        group.fillMode = .both
//        group.isRemovedOnCompletion = false
//        contentView.layer.add(group, forKey: "")
//
//        let madeAlphaAnim = CABasicAnimation(keyPath: "opacity")
//        madeAlphaAnim.fromValue = 0
//        madeAlphaAnim.toValue = 1
//
//        let madeGroup = CAAnimationGroup()
//        madeGroup.animations = [contentPositionAnim, contentBoundsAnim, madeAlphaAnim]
//        madeGroup.duration = self.duration
//        madeGroup.fillMode = .forwards
//        madeGroup.isRemovedOnCompletion = false
//        madeView?.layer.add(madeGroup, forKey: "made_group")
    }
    
    func closeAnimation() -> Void {
        self.effectView.isUserInteractionEnabled = true
//        self.effectView.isHidden = true
        
        UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: dampingRatio, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            
            self.contentView.frame = self.startRect!
            self.madeView?.frame = CGRect(x: 0, y: -100, width: self.view.frame.size.width * 0.6, height: 370)
            
            self.snapView?.alpha = 1
            self.madeView?.alpha = 0
            self.effectView.alpha = 0
            
        }) { (_) in
            self.effectView.isHidden = true
            self.fromView?.isHidden = false
            self.dismiss(animated: false, completion: {
                self.effectView.isUserInteractionEnabled = true
            })
        }
    }
    
    //MARK: 把传入的View截屏
    func snapshotView(shotView: UIView) -> INFSnapView {
        self.fromView = shotView
        let layer = shotView.layer
        let snapView = INFSnapView()
        let window = UIApplication.shared.keyWindow
        let frame = shotView.convert(shotView.bounds, to: window)
        snapView.frame = frame
        snapView.imageView.center = snapView.center
        snapView.imageView.frame = CGRect(x: 0, y: 0, width: snapView.frame.size.width, height: snapView.frame.size.height)
        /// 创建一个基于位图的上下文,并将其设置为当前的上下文.
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.isOpaque, UIScreen.main.scale)
        /// 获取上下文
        let context = UIGraphicsGetCurrentContext()
        /// 截屏
        layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        snapView.imageView.layer.contents = image?.cgImage
        return snapView
    }
}
