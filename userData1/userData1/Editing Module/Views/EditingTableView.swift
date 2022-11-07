//
//  EditingTableView.swift
//  userData1
//
//  Created by Юрий on 06.11.2022.
//

import UIKit

class EditingTableView: UITableView {
    
    private var userModel = UserModel()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        delegate = self
        dataSource = self
        
        register(type: TextViewTableViewCell.self)
        register(type: DatePickerTableViewCell.self)
        register(type: PickerViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUserModel(_ model: UserModel) {
        userModel = model
    }
    
    public func editUserModel() {
        
        guard let firstNameCell = self.cellForRow(at: [0,0]) as? TextViewTableViewCell,
              let secondNameCell = self.cellForRow(at: [0,1]) as? TextViewTableViewCell,
              let thirdNameCell = self.cellForRow(at: [0,2]) as? TextViewTableViewCell,
              let birthdayCell = self.cellForRow(at: [0,3]) as? DatePickerTableViewCell,
              let genderCell = self.cellForRow(at: [0,4]) as? PickerViewCell else { return }
        
        userModel.firstName = firstNameCell.getCellValue()
        userModel.secondName = secondNameCell.getCellValue()
        userModel.thirdName = thirdNameCell.getCellValue()
        userModel.birthday = birthdayCell.getCellValue()
        userModel.gender = genderCell.getCellValue()
    }
    
    public func getUserModel() -> UserModel {
        editUserModel()
        return userModel
    }
    
}

// MARK: TableViewDataSource
extension EditingTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Resources.NameFields.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nameField = Resources.NameFields.allCases[indexPath.row].rawValue
        
        switch indexPath.row {
        case 0...2:
            guard let cell = self.dequeueReusableCell(type: TextViewTableViewCell.self) else { return UITableViewCell() }
            cell.nameTextViewDelegate = self
            switch indexPath.row {
            case 0:
                cell.configure(name: nameField, scrollEnable: true, value: userModel.firstName)
            case 1:
                cell.configure(name: nameField, scrollEnable: false, value: userModel.secondName)
            default:
                cell.configure(name: nameField, scrollEnable: true, value: userModel.thirdName)
            }
            return cell
        case 3:
            guard let cell = self.dequeueReusableCell(type: DatePickerTableViewCell.self) else { return UITableViewCell() }
            cell.configure(name: nameField, date: userModel.birthday.getDateFromString())
            return cell
        case 4:
            guard let cell = self.dequeueReusableCell(type: PickerViewCell.self) else { return UITableViewCell() }
            cell.configure(name: nameField, value: userModel.gender)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}


extension EditingTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}

extension EditingTableView: NameTextViewProtocol {
    
    func changeSize() {
        beginUpdates()
        endUpdates()
    }
}
