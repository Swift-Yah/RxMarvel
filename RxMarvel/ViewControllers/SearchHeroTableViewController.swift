//
//  SearchHeroTableViewController.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/15/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxSwift

class SearchHeroTableViewController<T: BindableCellViewModel>: RxTableViewController {
    
    lazy var dataSource: SearchHeroDataSource<T> = {
        return SearchHeroDataSource(items: [], cellFactory: BindableCellFactory.cell)
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
        edgesForExtendedLayout = .All
    }
    
    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
    }
    
    // MARK: UITableViewController methods
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 97
    }
    
}
