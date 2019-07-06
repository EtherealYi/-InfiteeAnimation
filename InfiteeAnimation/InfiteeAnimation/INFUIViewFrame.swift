//
//  INFUIViewFrame.swift
//  InfiteeAnimation
//
//  Created by MasterYi on 2019/7/2.
//  Copyright © 2019 Master.Yi. All rights reserved.
//

import UIKit

extension UIView {
    
    class func viewFromXib() -> UIView{
        return Bundle.main.loadNibNamed(self.className(), owner: nil, options: nil)?.first as! UIView
    }
    
    var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            self.frame.size.width = newValue
        }
    }
    
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        
        set{
            self.frame.size.height = newValue
        }
    }
    
    var x: CGFloat{
        set{
            self.frame.origin.x = newValue
        }
        get{
            return self.frame.origin.x;
        }
    }
    
    var y: CGFloat{
        set{
            self.frame.origin.y = newValue
        }
        get{
            return self.frame.origin.y
        }
    }
    
    var centerX: CGFloat{
        set{
            self.center.x = newValue
        }
        get{
            return self.center.x
        }
    }
    
    var centerY: CGFloat{
        set{
            self.center.y = newValue
        }
        get{
            return self.center.y
        }
    }
    
    var left: CGFloat{
        set{
            self.frame.origin.x = newValue
        }
        get{
            return self.frame.origin.x;
        }
    }
    
    var right: CGFloat{
        set{
            self.x = newValue - self.width
        }
        get{
            return self.frame.maxX
        }
    }
    
    var top: CGFloat{
        set{
            self.frame.origin.y = newValue
        }
        get{
            return self.frame.origin.y
        }
    }
    
    var bottom: CGFloat{
        set{
            self.y = newValue - self.height
        }
        get{
            return self.frame.maxY
        }
    }
}


extension NSObject
{
    // MARK:返回className
    class func className() -> String{
        return NSStringFromClass(self)
    }
    
}

