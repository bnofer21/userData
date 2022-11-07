//
//  ViewController.swift
//  userData1
//
//  Created by Юрий on 06.11.2022.
//

import UIKit
import PhotosUI

class EditViewController: UIViewController {
    
    private let editingTableView = EditingTableView()
    
    private var userModel = UserModel()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var userPhotoIsChanged = false
    
    override func viewWillLayoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.frame.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
        addTaps()
        print(userModel)
    }
    
    init(_ userModel: UserModel, userImage: UIImage?) {
        self.userModel = userModel
        self.userImageView.image = userImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        title = "Редактирование"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(savePressed))
        let backBarButtonItem = UIBarButtonItem.createCustomButton(vc: self, selector: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backBarButtonItem
        editingTableView.setUserModel(userModel)
        view.addView(userImageView)
        view.addView(editingTableView)
    }
    
    @objc private func savePressed() {
        
        let editUserModel = editingTableView.getUserModel()
        
        if authFields(model: editUserModel) {
            presentSimpleALert(title: "Выполнено", message: "Все обязательные поля заполнены")
        } else {
            presentSimpleALert(title: "Ошибка", message: "Заполните поля ФИО, Дата рождения, Пол")
        }
    }
    
    @objc private func backButtonPressed() {
        
        let editUserModel = editingTableView.getUserModel()
        
        if authFields(model: editUserModel) == false {
            presentSimpleALert(title: "Ошибка", message: "Заполните поля ФИО, Дата рождения, Пол")
            return
        }
        
        if editUserModel == userModel && userPhotoIsChanged == false {
            navigationController?.popViewController(animated: true)
        } else {
            presentChangeAlert { [weak self] state in
                guard let self = self else { return }
                if state {
                    guard let firstVC = self.navigationController?.viewControllers.first as? MainViewController else { return }
                    firstVC.changeUserModel(model: editUserModel)
                    firstVC.changeUserPhoto(image: self.userImageView.image)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func authFields(model: UserModel) -> Bool {
        if model.firstName == "Введите данные" ||
            model.firstName == "" ||
            model.secondName == "Введите данные" ||
            model.secondName == "" ||
            model.birthday == "" ||
            model.gender == "" ||
            model.gender == "Не указано" {
            return false
        }
        return true
    }
    
    private func addTaps() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(setUserImage))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tapImageView)
    }
    
    @objc private func setUserImage() {
        if #available(iOS 14.0, *) {
            presentPHPicker()
        } else {
            presentImagePicker()
        }
    }
    
}

//MARK: Photo picker

extension EditViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private func presentImagePicker() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        userImageView.image = image
        userPhotoIsChanged = true
        dismiss(animated: true)
    }
}

@available(iOS 14.0, *)
extension EditViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.userImageView.image = image
                }
                self.userPhotoIsChanged = true
            }
        }
    }
    
    private func presentPHPicker() {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = PHPickerFilter.any(of: [.images])
        
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
    
}

//MARK: Set Constraints

extension EditViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 100),
            
            editingTableView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            editingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}





