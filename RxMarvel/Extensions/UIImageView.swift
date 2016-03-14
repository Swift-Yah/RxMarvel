//
// Created by Rafael Ferreira on 3/13/16.
// Copyright (c) 2016 Swift Yah. All rights reserved.
//

import AlamofireImage
import UIKit
import RxSwift

extension UIImageView {
    
    var rx_imageURL: AnyObserver<NSURL> {
        return AnyObserver { [weak self] event in
            switch event {
            case .Next(let value):
                if let strong = self {
                    strong.image = nil
                    
                    strong.af_setImageWithURL(value, completion: { [unowned strong] _ in
                        let transition = CATransition()
                        
                        transition.duration = 0.3
                        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                        
                        strong.layer.addAnimation(transition, forKey: kCATransition)
                        })
                }
            default:
                break
            }
        }
    }
    
}
