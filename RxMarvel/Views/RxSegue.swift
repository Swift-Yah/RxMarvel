//
//  RxSegue.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/15/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxSwift

class Segue<T> {
    
    /// The source view controller.
    private(set) weak var fromViewController: UIViewController?
    
    /**
     The destination view controller.
     
     - Note: When you don't want to pass a context just, use `Void` for it.
     */
    let toViewControllerFactory: (context: T) -> UIViewController
    
    // MARK: Initializers
    
    init(fromViewController: UIViewController, toViewControllerFactory: (context: T) -> UIViewController) {
        self.fromViewController = fromViewController
        self.toViewControllerFactory = toViewControllerFactory
    }
    
    // MARK: Lazy variables
    
    /// Segue as Push.
    private(set) lazy var pushObserver: AnyObserver<T> = AnyObserver { [weak self] event in
        switch event {
        case .Next(let value):
            guard let strong = self else { return }
            let toViewController = strong.toViewControllerFactory(context: value)
            
            guard let fromViewController = strong.fromViewController, navController = fromViewController.navigationController else { return }
            navController.pushViewController(toViewController, animated: true)
        default:
            break
        }
    }
    
    /// Segue as modal.
    private(set) lazy var presentObserver: AnyObserver<T> = AnyObserver { [weak self] event in
        switch event {
        case .Next(let value):
            guard let strong = self else { return }
            let toViewController = strong.toViewControllerFactory(context: value)
            
            guard let fromViewController = strong.fromViewController else { return }
            fromViewController.presentViewController(toViewController, animated: true, completion: nil)
        default:
            break
        }
        
        
    }
    
}
