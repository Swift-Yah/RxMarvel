//
//  NibProvidable.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit

protocol NibProvidable {
    
    static var nibName: String { get }
    static var nib: UINib { get }
    
}

extension NibProvidable {
    
    static var nibName: String {
        return "\(self)"
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
}