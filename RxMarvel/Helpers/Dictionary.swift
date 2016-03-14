//
//  Dictionary.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Foundation

func + <T, U>(var lhs: [T: U], rhs: [T: U]) -> [T: U] {
    for (key, value) in rhs {
        lhs[key] = value
    }
    
    return lhs
}
