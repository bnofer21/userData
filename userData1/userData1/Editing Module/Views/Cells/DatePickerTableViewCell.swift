import UIKit

class DatePickerTableViewCell: UITableViewCell {
    
    static var cellId = "DatePickerTableViewCell"
    
    private let nameLabel = UILabel()
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.subviews[0].subviews[0].subviews[0].alpha = 0
        return picker
    }()
    
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
        contentView.addView(datePicker)
    }
    
    public func configure(name: String, date: Date) {
        nameLabel.text = name
        datePicker.date = date
    }
    
    public func getCellValue() -> String {
        if datePicker.date.getStringFromDate() == Date().getStringFromDate() {
            return ""
        } else {
            return datePicker.date.getStringFromDate()
        }
    }
    
}

//MARK: Set Constraints
extension DatePickerTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            
            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}

