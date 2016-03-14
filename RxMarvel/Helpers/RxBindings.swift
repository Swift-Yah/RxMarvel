//
//  RxBindings.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxSwift

// MARK: One way binding operators

infix operator <~ { }

func <~ <T>(property: AnyObserver<T>, variable: Variable<T>) -> Disposable {
    return variable.asObservable().bindTo(property)
}

infix operator ~> { }

func ~> <T>(variable: Variable<T>, property: AnyObserver<T>) -> Disposable {
    return variable.asObservable().bindTo(property)
}
