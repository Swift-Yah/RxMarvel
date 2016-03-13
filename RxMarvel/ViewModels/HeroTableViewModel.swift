//
//  HeroTableViewModel.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxSwift

struct HeroTableViewModel {
    
    let title: Variable<String>
    let thumbnailType = ThumbnailType.Uncanny
    let thumbnailPath: Variable<NSURL>
    let hero: Hero
    
    // MARK: Initializers
    
    init(hero: Hero) {
        self.hero = hero
        title = Variable(hero.name)
        thumbnailPath = HeroTableViewModel.generateThumbnailPath(hero, thumbnailType: thumbnailType)
    }
    
    // MARK: Private methods
    
    static func generateThumbnailPath(hero: Hero, thumbnailType: ThumbnailType) -> Variable<NSURL> {
        let urlString = hero.thumbnail.pathForType(thumbnailType)
        
        let url = NSURL(string: urlString)!
        
        return Variable<NSURL>(url)
    }
    
    static func transform(heroes: [Hero]) -> [HeroTableViewModel] {
        return heroes.map(HeroTableViewModel.init)
    }
    
}
