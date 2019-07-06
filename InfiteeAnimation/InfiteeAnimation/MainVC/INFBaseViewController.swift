//
//  INFBaseViewController.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/3.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

class INFBaseViewController: UIViewController {

    public var animtorNavigationController: INFNavigationController?{
        get{
            if let navigation = self.navigationController as? INFNavigationController {
                return navigation
            }
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
