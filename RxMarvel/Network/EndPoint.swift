//
//  EndPoint.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Foundation

enum EndPoint: String {
    
    static let baseURL = "https://gateway.marvel.com/v1/public/"
    
    case Characters = "characters"
    
    var path: String {
        
        switch self {
        case .Characters:
            return EndPoint.baseURL + self.rawValue
        }
        
    }
    
}