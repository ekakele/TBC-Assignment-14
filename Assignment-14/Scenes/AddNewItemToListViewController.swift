//
//  AddNewItemToListViewController.swift
//  Assignment-14
//
//  Created by Eka Kelenjeridze on 30.10.23.
//

import UIKit

protocol AddNewSongDelegate: AnyObject {
    func addNewSong(song: Song)
}

class AddNewItemToListViewController: UIViewController {
    weak var delegate: AddNewSongDelegate?
    
    // MARK: - Properties
    private let nameTextField: UITextField = {
        let textField = UITextField()
        
        let addPadding: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftView = addPadding
        textField.leftViewMode = .always
        textField.rightView = addPadding
        textField.rightViewMode = .always
        textField.placeholder = "Enter Music Name"
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.backgroundColor = .systemGroupedBackground
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    private let uploadImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload Image", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let uploadedImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.widthAnchor.constraint(equalToConstant: 400).isActive = true
        image.heightAnchor.constraint(equalToConstant: 400).isActive = true
        image.backgroundColor = .systemGray5
        return image
    }()
    
    private let imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        return imagePicker
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 15
        return button
    }()
    
    private lazy var wrapperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 50
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.layoutMargins = .init(top: 50, left: 20, bottom: 50, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupNavigationBar()
        setupSubviews()
        setupWrapperStackViewConstraints()
        setupUploadImageButtonAction()
        setupUpSaveButtonAction()
    }
    
    // MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Add New Song"
    }
    
    private func setupImagePicker() {
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func setupSubviews() {
        view.addSubview(wrapperStackView)
        wrapperStackView.addArrangedSubview(nameTextField)
        wrapperStackView.addArrangedSubview(uploadImageButton)
        wrapperStackView.addArrangedSubview(uploadedImageView)
        wrapperStackView.addArrangedSubview(saveButton)
    }
    
    private func setupWrapperStackViewConstraints() {
        NSLayoutConstraint.activate([
            wrapperStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            wrapperStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            wrapperStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            wrapperStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupUploadImageButtonAction() {
        uploadImageButton.addTarget(self, action: #selector(navigateToPhotoLibrary), for: .touchUpInside)
    }
    
    @objc private func navigateToPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    private func setupUpSaveButtonAction() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        guard let songName = nameTextField.text, !songName.isEmpty, let songImage = uploadedImageView.image else {
            fatalError()
        }
        let newSong = Song(name: songName, image: songImage)
        delegate?.addNewSong(song: newSong)
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddNewItemToListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            uploadedImageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
