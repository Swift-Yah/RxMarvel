//
// Created by Rafael Ferreira on 3/13/16.
// Copyright (c) 2016 Swift Yah. All rights reserved.
//

import RxSwift

class RxTableViewCell<ViewModelType>: UITableViewCell, BindableView {
    
    typealias V = ViewModelType
    
    let rx_prepareForReuse: Observable<Void> = PublishSubject()
    
    // MARK: UITableViewCell methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        guard let rx_prepareForReuse = rx_prepareForReuse as? PublishSubject else { return }
        rx_prepareForReuse.onNext()
    }
    
    // MARK: Bindable conforms
    
    var rx_viewModel: AnyObserver<V> {
        return AnyObserver { event in
            // This is base class implementation
        }
    }
    
}
