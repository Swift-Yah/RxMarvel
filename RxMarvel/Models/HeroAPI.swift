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
    
    static var getableApi: JsonGET.Type = Marvel.self
    
    private static let decodeScheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "io.swift-yah.RxMarvel.HeroAPI.decodedQueue")
    
    typealias HeroTableResult = (heroes: Decoded<[Hero]>, batch: Decoded<Batch>)
    
    private static func recursiveHeroList(loadedSoFar: [Hero], offset: Int = 0, limit: Int, search: String, loadNextBatch: Observable<Void>) -> Observable<[Hero]> {
        let params: [String: AnyObject] = [
            ParamKeys.limit: limit,
            ParamKeys.offset: String(offset),
            ParamKeys.searchName: search
        ]
        
        return heroListSignal(params)
            .flatMap { (tuple: HeroTableResult) -> Observable<[Hero]> in
                guard let heroes = tuple.heroes.value, let batch = tuple.batch.value else {
                    return Observable.empty()
                }
                
                var loadedHeroes = loadedSoFar
                loadedHeroes.appendContentsOf(heroes)
                
                let nextOffset = batch.count + batch.offset
                
                if batch.offset == batch.total || nextOffset == batch.total {
                    return Observable.just(loadedHeroes)
                }
                
                return [
                    Observable.just(loadedHeroes),
                    Observable.never().takeUntil(loadNextBatch),
                    recursiveHeroList(loadedHeroes, offset: nextOffset, limit: batch.limit, search: search, loadNextBatch: loadNextBatch)
                    ].concat()
        }
    }
    
    private static func recursiveHeroList(offset: Int = 0, limit: Int, loadNextBatch: Observable<Void>) -> Observable<[Hero]> {
        
        let params: [String: AnyObject] = [
            ParamKeys.limit: limit,
            ParamKeys.offset: String(offset)
        ]
        
        return heroListSignal(params)
            .flatMap { (tuple: HeroTableResult) -> Observable <[Hero]> in
                guard let heroes = tuple.heroes.value, let batch = tuple.batch.value else {
                    return Observable.empty()
                }
                
                let nextOffset = batch.count + batch.offset
                
                if batch.offset == batch.total || nextOffset == batch.total {
                    return Observable.just(heroes)
                }
                
                return [
                    Observable.just(heroes),
                    Observable.never().takeUntil(loadNextBatch),
                    recursiveHeroList(nextOffset, limit: batch.limit, loadNextBatch: loadNextBatch)
                    ].concat()
        }
        
    }
    
    static func heroListSignal(params: [String: AnyObject]? = nil) -> Observable<HeroTableResult> {
        return getableApi
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

extension HeroAPI: HeroAutoLoading {
    
    static func getItems(offset: Int = 0, limit: Int, loadNextBatch: Observable<Void>) -> Observable<[Hero]> {
        return recursiveHeroList(offset, limit: limit, loadNextBatch: loadNextBatch)
    }
    
    static func searchItems(offset: Int = 0, limit: Int = 40, search: String, loadNextBatch: Observable<Void>) -> Observable<[Hero]> {
        return recursiveHeroList([], offset: offset, limit: limit, search: search, loadNextBatch: loadNextBatch)
    }
    
}
