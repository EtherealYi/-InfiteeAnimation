//
//  INFMenuModel.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/11.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

struct INFMenuModel {
    var menuName: String
    var isAnimatiion: Bool = false
    var delayTime: TimeInterval = 0
    init(menu: String) {
        menuName = menu
    }
}
