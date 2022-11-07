import Foundation

enum Resources {
    
    
    enum NameFields: String, CaseIterable {
        case firstName = "Имя"
        case secondName = "Фамилия"
        case thirdName = "Отчество"
        case birthday = "Дата рождения"
        case gender = "Пол"
    }
    
    enum Gender: String, CaseIterable {
        case notSelected = "Не указано"
        case male = "Мужской"
        case female = "Женский"
    }
    
}
