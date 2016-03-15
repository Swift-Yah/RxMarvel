//
//  SearchHeroTableAdapter.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/15/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchHeroTableAdapter<Element, U: BindableCellViewModel> {
    
    typealias SearchEvent = (offset: Int, limit: Int, search: String, nextBatchTrigger: Observable<Void>) -> Observable<[Element]>
    
    // MARK: Lazy variables
    
    lazy var searchViewController = SearchHeroTableViewController<U>(style: .Plain)
    
    lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: self.searchViewController)
    }()
    
    // MARK: Dispose bags
    
    private(set) var disposeBag = DisposeBag()
    
    // MARK: Initializers
    
    init(searchEvent: SearchEvent, viewModelMap: [Element] -> [U]) {
        let searchSignal = searchController
            .searchBar
            .rx_text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [unowned self] (search: String) -> Observable<[U]> in
                if search.isEmpty {
                    return Observable.empty()
                }
                
                return searchEvent(offset: 0, limit: 10, search: search, nextBatchTrigger: self.searchViewController.tableView.rx_nextPageTrigger)
                    .map(viewModelMap)
                }
        
        searchSignal
            .filter { [unowned self] _ -> Bool in return self.searchViewController.dataSource.items.isEmpty }
            .asDriver(onErrorJustReturn: [])
            .driveNext(searchViewController.dataSource.appendItems(.Top, tableView: searchViewController.tableView))
            .addDisposableTo(disposeBag)
        
        searchSignal
            .filter { [unowned self] _ -> Bool in return !self.searchViewController.dataSource.items.isEmpty }
            .asDriver(onErrorJustReturn: [])
            .driveNext(searchViewController.dataSource.setItems(.Top, tableView: searchViewController.tableView))
            .addDisposableTo(disposeBag)
    }
    
    
}
