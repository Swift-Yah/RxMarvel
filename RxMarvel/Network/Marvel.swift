//
//  Marvel.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift

struct Marvel {
    
    private struct Keys {
        static let privateKey = "a17fd4c41a55d4c5c2845f18b785d453"
        static let publicKey = "28d6caee2530ae4791e22b142edadd4a99033d9e"
    }
    
    private static let formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        
        return formatter
    }()
    
    private static var defaultParams: [String: AnyObject] {
        let timeStamp = formatter.stringFromDate(NSDate())
        
        let hash = "\(timeStamp)\(Keys.privateKey)\(Keys.publicKey)".md5
        
        return [
            ParamKeys.apiKey: Keys.publicKey,
            ParamKeys.hash: hash,
            ParamKeys.timeStamp: timeStamp
        ]
    }
}

extension Marvel: JsonGET {
    
    static func getData(endPoint: EndPoint)(parameters: [String: AnyObject]?) -> Observable<AnyObject> {
        let params = defaultParams + (parameters ?? [:])
        
        return Alamofire.request(.GET, endPoint.path, parameters: params).rx_JSON()
    }
    
}
