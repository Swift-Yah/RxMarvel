//
//  HeroAutoLoading.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/14/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxSwift

protocol HeroAutoLoading {
    
    static func getItems(offset: Int, limit: Int, loadNextBatch: Observable<Void>) -> Observable<[Hero]>
    static func searchItems(offset: Int, limit: Int, search: String, loadNextBatch: Observable<Void>) -> Observable<[Hero]>
    
}
