//
//  INFFrameAnimator.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/15.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFFrameAnimator: INFTransitionAnimator, CAAnimationDelegate {

    override func startAnimation() {
        super.startAnimation()
        
        toView?.frame = context!.finalFrame(for: toViewController!)
//        toView?.alpha = 0
        contaionerView?.addSubview(toView!)
        toView.layer.removeAllAnimations()
        fromView.layer.removeAllAnimations()
        if operation == UINavigationController.Operation.push {
            let appearAnim = CABasicAnimation(keyPath: "opacity")
            appearAnim.delegate = self
            appearAnim.duration = duration
            appearAnim.fromValue = 0
            appearAnim.toValue = 1
            appearAnim.fillMode = .forwards
            appearAnim.isRemovedOnCompletion = false
            toView.layer.add(appearAnim, forKey: "toView_AppearAnim")

            let pushPositionAnim = CABasicAnimation(keyPath: "position.y")
            pushPositionAnim.duration = duration
            pushPositionAnim.delegate = self
            pushPositionAnim.fromValue = fromView.layer.position.y
            pushPositionAnim.toValue = fromView.layer.position.y-120
            pushPositionAnim.timingFunction = CAMediaTimingFunction(name: .easeOut)
            pushPositionAnim.fillMode = .forwards
            pushPositionAnim.isRemovedOnCompletion = false
            fromView.layer.add(pushPositionAnim, forKey: "push_Anim")

        }else{
            let popPositionAnim = CABasicAnimation(keyPath: "position.y")
            popPositionAnim.fromValue = toView.layer.position.y - 120
            popPositionAnim.toValue = UIScreen.main.bounds.height / 2

            let popDisappearAnim = CABasicAnimation(keyPath: "opacity")
            popDisappearAnim.fromValue = 0
            popDisappearAnim.toValue = 1
        
            let popGroup = CAAnimationGroup()
            popGroup.duration = duration
            popGroup.delegate = self
            popGroup.animations = [popPositionAnim, popDisappearAnim]
            popGroup.fillMode = .forwards
            popGroup.timingFunction = CAMediaTimingFunction(name: .easeOut)
            popGroup.isRemovedOnCompletion = false
            toView.layer.add(popGroup, forKey: "pop_Anim")
            
        }
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            if fromView.layer.animation(forKey: "push_Anim") == anim {
                let canceled = self.context!.transitionWasCancelled
                self.context?.completeTransition(!canceled)
                fromView.layer.removeAllAnimations()
            }else if toView.layer.animation(forKey: "pop_Anim") == anim {
                let canceled = self.context!.transitionWasCancelled
                self.context?.completeTransition(!canceled)
                toView.layer.removeAllAnimations()
            }
        }
    }
}
