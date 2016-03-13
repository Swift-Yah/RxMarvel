//
//  HeroAPI.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Argo
import RxSwift

struct HeroAPI {
    
    private static let decodeScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "io.swift-yah.RxMarvel.HeroAPI.decodedQueue")
    
    typealias HeroTableResult = (heroes: Decoded<[Hero]>, batch: Decoded<Batch>)
    
    private static func recursiveHeroList(offset: Int = 0, limit: Int, loadNextBatch: Observable<Void>) -> Observable<[Hero]> {
        
        let params = [
            ParamKeys.limit: limit,
            ParamKeys.offset: offset
        ]
        
        return heroListSignal(params)
            .flatMap { (tuple: HeroTableResult) -> Observable < [Hero]> in
                guard let heroes = tuple.heroes.value, let batch = tuple.batch.value else {
                    return Observable.empty()
                }
                
                let futureTotal = batch.offset + batch.count
                
                if batch.offset == batch.total || futureTotal == batch.total {
                    return Observable.just(heroes)
                }
                
                return [
                    Observable.just(heroes),
                    Observable.never().takeUntil(loadNextBatch),
                    recursiveHeroList(limit: batch.limit, loadNextBatch: loadNextBatch)
                    ].concat()
        }
        
    }
    
    static func heroListSignal(params: [String: AnyObject]? = nil) -> Observable<HeroTableResult> {
        return Marvel
            .getData(.Characters)(parameters: params)
            .observeOn(decodeScheduler)
            .map(HeroDecoder.decode)
    }
    
}

extension HeroAPI {
    
    struct HeroDecoder {
        static func decode(json: AnyObject) -> HeroTableResult {
            if let batchDictionary = JSONDictionary(json)(key: "data"), let heroesArray = batchDictionary["results"] {
                return (Argo.decode(heroesArray), Argo.decode(batchDictionary))
            }
            
            let invalidJSON = DecodeError.Custom("Invalid JSON")
            
            return (Decoded.Failure(invalidJSON), Decoded.Failure(invalidJSON))
        }
    }
    
}
