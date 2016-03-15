//
//  ChangeableDataSourceType.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/15/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit

protocol ChangeableDataSourceType {
    
    typealias T
    
    func setItems(animation: UITableViewRowAnimation, tableView: UITableView)(items: [T])
    
}