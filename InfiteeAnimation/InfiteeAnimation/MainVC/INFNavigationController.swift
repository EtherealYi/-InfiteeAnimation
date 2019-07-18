//
//  INFNavigationController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/6/27.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFNavigationController: UINavigationController, UINavigationControllerDelegate {

    var animator: INFTransitionAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        self.delegate = self
        
    }
    
    func pushToVC(viewControllrt: UIViewController, animator: INFTransitionAnimator?) -> Void {
        self.animator = animator
        self.pushViewController(viewControllrt, animated: true)
    }
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if animator != nil {
            animator?.operation = operation
            return animator
        }
        return nil
    }

}

extension INFNavigationController {
    
}
