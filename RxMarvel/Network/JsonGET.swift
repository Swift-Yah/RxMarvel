//
//  JsonGET.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Alamofire
import RxSwift

protocol JsonGET {
    
    static func getData(endPoint: EndPoint)(parameters: [String: AnyObject]?) -> Observable<AnyObject>
    
}
