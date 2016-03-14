//
//  BindableView.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxSwift

protocol BindableView {

    typealias V

    var rx_viewModel: AnyObserver<V> { get }

}
