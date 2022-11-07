//
//  ViewController.swift
//  userData1
//
//  Created by Юрий on 06.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mainTableView = MainTableView()
    
    private var userModel = UserModel()
    
    override func viewWillLayoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.frame.width/2
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setConstraints()
        getUserModel()
        setValueArray()
    }
    
    private func setupView() {
        title = "Просмотр"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(editingPressed))
        
        view.addView(userImageView)
        view.addView(mainTableView)
    }
    
    @objc private func editingPressed() {
        let editVC = EditViewController(userModel, userImage: userImageView.image)
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    private func getUserModel() {
        userModel = UserDefaultsManager.getUserModel()
        let userPhoto = UserDefaultsManager.loadUserImage()
        userImageView.image = userPhoto
    }
    
    private func saveEditModel(_ model: UserModel) {
        UserDefaultsManager.saveUserValue(Resources.NameFields.firstName.rawValue, model.firstName)
        UserDefaultsManager.saveUserValue(Resources.NameFields.secondName.rawValue, model.secondName)
        UserDefaultsManager.saveUserValue(Resources.NameFields.thirdName.rawValue, model.thirdName)
        UserDefaultsManager.saveUserValue(Resources.NameFields.birthday.rawValue, model.birthday)
        UserDefaultsManager.saveUserValue(Resources.NameFields.gender.rawValue, model.gender)
    }
    
    private func getValueArray() -> [String] {
        var valueArray = [String]()
        
        for key in Resources.NameFields.allCases {
            let value = UserDefaultsManager.getUserValue(key.rawValue)
            valueArray.append(value)
        }
        return valueArray
    }
    
    private func setValueArray() {
        let valueArray = getValueArray()
        mainTableView.setValueArray(valueArray)
        mainTableView.reloadData()
    }
    
    public func changeUserModel(model: UserModel) {
        saveEditModel(model)
        
        userModel = model
        setValueArray()
        mainTableView.reloadData()
    }
    
    public func changeUserPhoto(image: UIImage?) {
        userImageView.image = image
        guard let userPhoto = image else { return }
        UserDefaultsManager.saveUserImage(image: userPhoto)
    }
}

extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            
            mainTableView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}



