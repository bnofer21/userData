//
//  MainTableView.swift
//  userData1
//
//  Created by Юрий on 06.11.2022.
//

import UIKit

class MainTableView: UITableView {
    
    private var valueArray = [String]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        delegate = self
        dataSource = self
        
        register(type: MainTableViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: TableViewDataSource
extension MainTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Resources.NameFields.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(type: MainTableViewCell.self) else { return UITableViewCell() }
        
        let nameField = Resources.NameFields.allCases[indexPath.row].rawValue
        let value = valueArray[indexPath.row]
        cell.configure(name: nameField, value: value)
        return cell
    }
    
    public func setValueArray(_ array: [String]) {
        valueArray = array
    }
    
}


extension MainTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}
