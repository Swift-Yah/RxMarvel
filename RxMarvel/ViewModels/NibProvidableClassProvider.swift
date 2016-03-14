//
//  NibProvidableClassProvider.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Foundation

protocol NibProvidableClassProvider {
    
    var nibProvidableType: NibProvidable.Type { get }
    
}
