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
    let thumbnailType = ThumbnailType.Medium
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

extension HeroTableViewModel: NibProvidableClassProvider {
    
    var nibProvidableType: NibProvidable.Type {
        return HeroTableViewCell.self
    }
    
}

extension HeroTableViewModel: ReuseableViewClassProvider {
    
    var reusableViewType: ReusableView.Type {
        return HeroTableViewCell.self
    }
    
}

extension HeroTableViewModel: VariableProvidable {
    
    var variable: Variable<HeroTableViewModel> {
        return Variable(self)
    }
    
}

extension HeroTableViewModel: Hashable {
    
    var hashValue: Int {
        return title.value.hash ^ thumbnailPath.value.hash
    }
    
}

func == (lhs: HeroTableViewModel, rhs: HeroTableViewModel) -> Bool {
    let thumbnailEqual = lhs.thumbnailPath.value == rhs.thumbnailPath.value
    let thumbnailTypeEqual = lhs.thumbnailType == rhs.thumbnailType
    let titleEqual = lhs.title.value == rhs.title.value
    
    return thumbnailEqual && thumbnailTypeEqual && titleEqual
}
