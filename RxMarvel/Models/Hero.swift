//
//  Hero.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Argo
import Curry

struct Hero {
    
    let id: Int
    let name: String
    let thumbnail: Thumbnail
    
}

extension Hero: Decodable {
    
    static func decode(json: JSON) -> Decoded<Hero> {
        return curry(Hero.init)
            <^> json <| "id"
            < * > json <| "name"
            < * > json <| "thumbnail"
    }
    
}