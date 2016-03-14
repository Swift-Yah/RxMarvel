//
//  ReuseableViewClassProvider.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Foundation

protocol ReuseableViewClassProvider {
    
    var reusableViewType: ReusableView.Type { get }
    
}