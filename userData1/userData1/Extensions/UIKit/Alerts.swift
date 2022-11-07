//
//  Alerts.swift
//  userData1
//
//  Created by Юрий on 06.11.2022.
//

import UIKit

extension UIViewController {
    
    func presentSimpleALert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okACtion = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okACtion)
        present(alertController, animated: true)
    }
    
    func presentChangeAlert(completionHandler: @escaping (Bool) -> Void) {
        
        let alertController = UIAlertController(title: "Данные были изменены", message: "Сохранить?", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            completionHandler(true)
        }
        let skipAction = UIAlertAction(title: "Пропустить", style: .default) { _ in
            completionHandler(false)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(skipAction)
        
        present(alertController, animated: true)
    }
}
