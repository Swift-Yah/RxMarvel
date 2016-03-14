//
//  Thumbnail.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Argo
import Curry

struct Thumbnail {
    
    let path: String
    let pathExtension: String
    
    func pathForType(type: ThumbnailType) -> String {
        let stringFormat = "%@/%@.%@"
        
        return String(format: stringFormat, path, type.rawValue, pathExtension)
    }
    
}

extension Thumbnail: Decodable {
    
    static func decode(json: JSON) -> Decoded<Thumbnail> {
        return curry(Thumbnail.init)
            <^> json <| "path"
            <*> json <| "extension"
    }
    
}