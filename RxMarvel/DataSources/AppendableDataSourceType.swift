//
//  AppendableDataSourceType.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/13/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit

protocol AppendableDataSourceType {
    
    typealias T
    
    func appendItems(animation: UITableViewRowAnimation, tableView: UITableView) -> (items: [T]) -> Void
    
}
