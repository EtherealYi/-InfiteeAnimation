//
//  INFTabBarAnimation.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/2.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

extension UITabBar {
    open override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        
        if event == "position" {
            if layer.position.x < 0 {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationHiddenBarBottom), object: ["operation": "fromTop"])
                let pushFromTop = CATransition()
                pushFromTop.duration = 0.4
                pushFromTop.type = .push
                pushFromTop.subtype = .fromTop
                pushFromTop.timingFunction = CAMediaTimingFunction(name: .easeOut)

                return pushFromTop
            }else if ((layer.position.x > 0) && (layer.position.y>layer.bounds.size.height)&&(layer.position.y<UIScreen.main.bounds.size.height)) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationHiddenBarBottom), object: ["operation": "fromBottom"])
                let pushFromBottom = CATransition()
                pushFromBottom.duration = 0.4
                pushFromBottom.timingFunction = CAMediaTimingFunction(name: .easeOut)
                pushFromBottom.type = .push
                pushFromBottom.subtype = .fromBottom

                return pushFromBottom
            }
            return nil
        }
        return nil
    }
}
