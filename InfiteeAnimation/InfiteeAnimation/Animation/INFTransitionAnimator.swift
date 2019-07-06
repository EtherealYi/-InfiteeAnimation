//
//  INFTransitionAnimator.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/2.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// 转场时间
    public var duration: TimeInterval = 0.6
    /// 转场的上下文
    public var context: UIViewControllerContextTransitioning!
    /// 源控制器
    public var fromViewController: UIViewController!
    /// 目标控制器
    public var toViewController: UIViewController!
    /// 源控制器的 view
    public var fromView: UIView!
    /// 目标控制器的 view
    public var toView: UIView!
    /// 进行动画过渡的场所
    public var contaionerView: UIView!
    /// 转场方式
    public var operation: UINavigationController.Operation!
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        context = transitionContext
        fromViewController = transitionContext.viewController(forKey: .from)
        toViewController = transitionContext.viewController(forKey: .to)
        
        fromView = fromViewController?.view
        toView = toViewController?.view
        
        contaionerView = transitionContext.containerView
        
        startAnimation()
    }
    

    func startAnimation() -> Void {
        
    }
    
    
    
}
