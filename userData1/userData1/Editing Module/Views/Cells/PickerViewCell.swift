//
//  PickerViewCell.swift
//  userData1
//
//  Created by Юрий on 06.11.2022.
//

import Foundation

import UIKit

class PickerViewCell: UITableViewCell {
    
    static var cellId = "PickerViewCell"
    
    private let genderTextField = GenderTextField()
    private let nameLabel = UILabel()
    private let genderPickerView = GenderPickerView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        addView(nameLabel)
        nameLabel.font = nameLabel.font.withSize(18)
        contentView.addView(genderTextField)
        genderTextField.inputView = genderPickerView
        genderPickerView.genderDelegate = self
    }
    
    public func configure(name: String, value: String) {
        nameLabel.text = name
        genderTextField.text = value
    }
    
    public func getCellValue() -> String {
        guard let text = genderTextField.text else { return "" }
        return text
    }
    
}

extension PickerViewCell: GenderPickerViewProtocol {
    
    func didSelect(row: Int) {
        genderTextField.text = Resources.Gender.allCases[row].rawValue
        genderTextField.resignFirstResponder()
    }
    
}

//MARK: Set Constraints
extension PickerViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            
            genderTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            genderTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 10),
            genderTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            genderTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}

