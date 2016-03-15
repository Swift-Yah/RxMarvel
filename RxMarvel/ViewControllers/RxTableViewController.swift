//
//  RxTableViewController.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/15/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit
import RxSwift

class RxTableViewController: UITableViewController {
    
    // MARK: Dispose Bags
    
    private(set) var disposeBag = DisposeBag()
    
    // MARK: Observables
    
    let rx_viewDidLoad: Observable<Void> = PublishSubject()
    let rx_viewDidAppear: Observable<Void> = PublishSubject()
    let rx_viewDidDisappear: Observable<Void> = PublishSubject()
    let rx_viewWillAppear: Observable<Void> = PublishSubject()
    let rx_viewWillDisappear: Observable<Void> = PublishSubject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let rx_viewDidLoad = rx_viewDidLoad as? PublishSubject else { return }
        rx_viewDidLoad.onNext()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let rx_viewDidAppear = rx_viewDidAppear as? PublishSubject else { return }
        rx_viewDidAppear.onNext()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let rx_viewDidDisappear = rx_viewDidDisappear as? PublishSubject else { return }
        rx_viewDidDisappear.onNext()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let rx_viewWillAppear = rx_viewWillAppear as? PublishSubject else { return }
        rx_viewWillAppear.onNext()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let rx_viewWillDisappear = rx_viewWillDisappear as? PublishSubject else { return }
        rx_viewWillDisappear.onNext()
    }
    
}
