//
//  UITableView.swift
//  userData1
//
//  Created by Юрий on 06.11.2022.
//

import UIKit

extension UITableView {
    
    func register(type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(type, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
    
}
