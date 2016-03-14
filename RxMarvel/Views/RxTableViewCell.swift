//
// Created by Rafael Ferreira on 3/13/16.
// Copyright (c) 2016 Swift Yah. All rights reserved.
//

import RxSwift

class RxTableViewCell<ViewModelType>: UITableViewCell, BindableView {
    
    typealias V = ViewModelType
    
    let onPrepareForReuse: Observable<Void> = PublishSubject()
    
    var rx_viewModel: AnyObserver<V> {
        return AnyObserver { event in
            // This is base class implementation
        }
    }
    
}
