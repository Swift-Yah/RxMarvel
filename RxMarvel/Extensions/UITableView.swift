//
//  UITableView.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxCocoa
import RxSwift

extension UITableView {
    
    var rx_nextPageTrigger: Observable<Void> {
        return self
            .rx_contentOffset
            .flatMapLatest { [unowned self](offset: CGPoint) -> Observable < Void> in
                let yAxis = offset.y
                let frameHeight = self.frame.size.height
                let contentHeight = self.contentSize.height
                
                let shouldTrigger = yAxis + frameHeight + 40 > contentHeight
                
                return shouldTrigger ? Observable.just() : Observable.empty()
        }
    }
    
}
