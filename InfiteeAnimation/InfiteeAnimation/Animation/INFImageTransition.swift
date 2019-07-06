//
//  INFImageTransitio.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/2.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFImageTransition: INFTransitionAnimator {

    public var imageViewRect: CGRect?
    public var transitionimageView: UIImageView?
    
    override func startAnimation() {
        super.startAnimation()
        toView?.frame = context!.finalFrame(for: toViewController!)
        toView?.alpha = 0
        contaionerView?.addSubview(toView!)
        self.transitionimageView?.isHidden = true
        let imageView = UIImageView(image: self.transitionimageView?.image)
        let window = UIApplication.shared.delegate?.window
        
        let startRect = self.transitionimageView?.convert(self.transitionimageView!.bounds, to: window!)
        
        if self.operation == .push {
            imageView.frame = startRect!
        }else{
            imageView.frame = imageViewRect!
        }
        
        contaionerView?.addSubview(imageView)
        
        UIView.animate(withDuration: 0.3) {
            self.toView!.alpha = 1
        }
        
        UIView.animate(withDuration: self.duration, animations: {
            if self.operation == .push {
                
                imageView.frame = self.imageViewRect!;
            }else{
                imageView.frame = startRect!;
            }
            
        }) { (finished) in
            if let imageVc = self.toViewController as? INFImageViewController{
                imageVc.setImage(image: imageView.image!)
            }
            imageView.removeFromSuperview()
            
            self.transitionimageView?.isHidden = false
            let canceled = self.context!.transitionWasCancelled
            self.context?.completeTransition(!canceled)
        }
    }
}
