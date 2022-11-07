//
//  Date.swift
//  userData1
//
//  Created by Юрий on 06.11.2022.
//

import Foundation

extension Date {
    
    func getStringFromDate() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
