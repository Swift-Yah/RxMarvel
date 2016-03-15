//
//  SearchDataSource.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/15/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit

class SearchHeroDataSource<Element>: AppendableDataSource<Element> {
    
    override init(items: [T], cellFactory: (UITableView, NSIndexPath, T) -> UITableViewCell) {
        super.init(items: items, cellFactory: cellFactory)
    }
    
}

extension SearchHeroDataSource: ChangeableDataSourceType {
    
    func setItems(animation: UITableViewRowAnimation, tableView: UITableView)(items: [T]) {
        self.items = items
        
        tableView.reloadData()
    }
    
}
