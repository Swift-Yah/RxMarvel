//
//  BindableCellFactory.swift
//  RxMarvel
//
//  Created by Rafael Ferreira on 3/14/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit

typealias BindableCellViewModel = protocol<NibProvidableClassProvider, ReuseableViewClassProvider, VariableProvidable>

struct BindableCellFactory<V: BindableCellViewModel> {
    
    typealias CellType = RxTableViewCell<V>
    
    static func cell(tableView: UITableView, indexPath: NSIndexPath, viewModel: V) -> UITableViewCell {
        
        guard let reusableCell = tableView.dequeueReusableCellWithIdentifier(viewModel.reusableViewType.reuseIdentifier) else {
            tableView.registerNib(viewModel.nibProvidableType.nib, forCellReuseIdentifier: viewModel.reusableViewType.reuseIdentifier)
            
            return cell(tableView, indexPath: indexPath, viewModel: viewModel)
        }
        
        if let rxCell = reusableCell as? CellType {
            rxCell.rx_viewModel <~ viewModel.variable
        }
        
        return reusableCell
    }
    
}
