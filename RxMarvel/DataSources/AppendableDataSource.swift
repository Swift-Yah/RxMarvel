//
//  AppendableDataSource.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit

class AppendableDataSource<Element>: NSObject, AppendableDataSourceType, UITableViewDataSource {
    
    typealias T = Element
    
    var items: [T]
    
    private let cellFactory: (UITableView, NSIndexPath, T) -> UITableViewCell
    
    // MARK: Initializers
    
    init(items: [T], cellFactory: (UITableView, NSIndexPath, T) -> UITableViewCell) {
        self.items = items
        self.cellFactory = cellFactory
    }
    
    // MARK: AppendableDataSourceType conforms
    
    func appendItems(animation: UITableViewRowAnimation, tableView: UITableView) -> (items: [T]) -> Void {
        return { items in
            if items.isEmpty {
                return
            }
            
            let range = self.items.count ... (self.items.count + (items.count - 1))
            let indexPaths = range.map{ (i: Int) in
                return NSIndexPath(forRow: i, inSection: 0)
            }
            
            self.items.appendContentsOf(items)
            
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
        }
    }
    
    // MARK: UITableViewDataSource conforms
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        return cellFactory(tableView, indexPath, items[row])
    }
    
    
}
