//
//  ReusableView.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit

protocol ReusableView {
    
    static var reuseIdentifier: String { get }
    
}

extension ReusableView {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
}
