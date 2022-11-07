//
//  GenderTextField.swift
//  userData1
//
//  Created by Юрий on 06.11.2022.
//

import UIKit

class GenderTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        attributedPlaceholder = NSAttributedString(string: "Введите данные", attributes: [.foregroundColor : UIColor.lightGray])
        textAlignment = .right
        tintColor = .clear
        font = font?.withSize(18)
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        !isFirstResponder
    }
}
