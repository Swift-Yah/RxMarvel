//
//  JSON.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Foundation
import Runes

func JSONDictionary(json: AnyObject) -> [String: AnyObject]? {
    return json as? [String: AnyObject]
}

func JSONDictionary(json: AnyObject)(key: String) -> [String: AnyObject]? {
    if let dictionary = JSONDictionary - << json {
        return JSONDictionary - << dictionary[key]
    }
    
    return nil
}
