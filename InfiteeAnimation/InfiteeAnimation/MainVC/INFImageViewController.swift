//
//  INFImageViewController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/3.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFImageViewController: INFBaseViewController {

    public var transitionImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    public func setImage(image: UIImage) -> Void {
        self.transitionImage = image
    }

}
