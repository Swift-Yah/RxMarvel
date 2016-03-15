//
//  ViewController.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxSwift

/// The view controller for hero table view at `Main.storyboard`.
class HeroTableViewController: UITableViewController {
    
    private(set) var disposeBag = DisposeBag()
    
    private(set) lazy var dataSource: AppendableDataSource<HeroTableViewModel> = {
        return AppendableDataSource(items: [], cellFactory: BindableCellFactory.cell)
    }()
    
    lazy var api: HeroAutoLoading.Type = HeroAPI.self
    
    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        loadData()
    }
    
    // MARK: Private methods
    
    private func setUpTableView() {
        tableView.delegate = nil
        tableView.dataSource = dataSource
    }
    
    private func loadData() {
        api.getItems(dataSource.items.count, limit: 40, loadNextBatch: tableView.rx_nextPageTrigger)
            .map(HeroTableViewModel.transform)
            .asDriver(onErrorJustReturn: [])
            .driveNext(dataSource.appendItems(.Top, tableView: tableView))
            .addDisposableTo(disposeBag)
    }
    
}
