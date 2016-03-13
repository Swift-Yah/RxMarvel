//
//  Batch.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Argo
import Curry

struct Batch {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
}

extension Batch: Decodable {
    
    static func decode(json: JSON) -> Decoded<Batch> {
        return curry(Batch.init)
            <^> json <| "offset"
            < * > json <| "limit"
            < * > json <| "total"
            < * > json <| "count"
    }
    
}
