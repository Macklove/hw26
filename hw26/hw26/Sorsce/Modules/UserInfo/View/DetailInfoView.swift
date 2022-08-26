//
//  DetailInfoView.swift
//  hw26
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation
import UIKit

class DetailInfoView: UIView {
    
    let genderPickerView = GenderView()
    
    // переменные
    lazy var photoUserView: UIImageView = {
        var imageView = UIImageView()
        var image = UIImage(named: "istockphoto")
        imageView.image = image
        imageView.clipsToBounds = true
        let imageHeightWidth: CGFloat = 250
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageHeightWidth / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var birthdayDatePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date.now
        datePicker.tintColor = .systemGray
        return datePicker
    }()
    
    lazy var parentStackView = createStackView(axis: .vertical, distribution: .fill, alignment: .leading)
    private lazy var nameStackView = createStackView(axis: .horizontal, distribution: .fill, alignment: .leading)
    private lazy var birthdayStackView = createStackView(axis: .horizontal, distribution: .fill, alignment: .leading)
    private lazy var genderStackView = createStackView(axis: .horizontal, distribution: .fill, alignment: .leading)
    
    //иконки
    private lazy var nameIcon = createIcons(imageName: "person")
    private lazy var birthdayIcon = createIcons(imageName: "calendar")
    private lazy var genderIcon = createIcons(imageName: "person.2")
    
    lazy var nameTextField = createTextFields(with: "name")
    lazy var genderTextField = createTextFields(with: "Gender")
    
    private lazy var genderToolBar = createGenderToolbar()
    
    private lazy var lineSeparatorOne = makeLineSeparator()
    private lazy var lineSeparatorTwo = makeLineSeparator()
    private lazy var lineSeparatorThree = makeLineSeparator()
    
    //MARK: - Инициализация
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupHierarchy()
        setupLayout()
        configureGenderTextField(textField: genderTextField, toolbar: genderToolBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //методы
    private func createStackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = 20
        stackView.alignment = alignment
        return stackView
    }
    
    private func makeLineSeparator() -> UIView {
        let lineSeparator = UIView()
        lineSeparator.layer.borderColor = UIColor.gray.cgColor
        lineSeparator.layer.borderWidth = (1.0 / UIScreen.main.scale) / 2
        return lineSeparator
    }
    
    func configure(from model: Person) {
        nameTextField.text = model.name
        birthdayDatePicker.date = model.data ?? Date.now
        genderTextField.text = model.gender
    }
    
    private func createTextFields(with placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        return textField
    }
    
    private func createIcons(imageName: String) -> UIImageView {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24, weight: .semibold))
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: imageName, withConfiguration: configuration)
        imageView.tintColor = .systemGray
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return imageView
    }
    
    private func setupHierarchy() {
        addSubview(photoUserView)
        addSubview(parentStackView)
        parentStackView.addArrangedSubview(nameStackView)
        parentStackView.addArrangedSubview(lineSeparatorOne)
        parentStackView.addArrangedSubview(birthdayStackView)
        parentStackView.addArrangedSubview(lineSeparatorTwo)
        parentStackView.addArrangedSubview(genderStackView)
        parentStackView.addArrangedSubview(lineSeparatorThree)
        
        nameStackView.addArrangedSubview(nameIcon)
        nameStackView.addArrangedSubview(nameTextField)
        
        birthdayStackView.addArrangedSubview(birthdayIcon)
        birthdayStackView.addArrangedSubview(birthdayDatePicker)
        
        
        genderStackView.addArrangedSubview(genderIcon)
        genderStackView.addArrangedSubview(genderTextField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            photoUserView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            photoUserView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photoUserView.heightAnchor.constraint(equalToConstant: 250),
            photoUserView.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            parentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            parentStackView.topAnchor.constraint(equalTo: photoUserView.bottomAnchor, constant: 20),
            parentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            lineSeparatorOne.heightAnchor.constraint(equalToConstant: 1),
            lineSeparatorOne.leadingAnchor.constraint(equalTo: parentStackView.leadingAnchor),
            lineSeparatorOne.trailingAnchor.constraint(equalTo: parentStackView.trailingAnchor),
            
            lineSeparatorTwo.heightAnchor.constraint(equalToConstant: 1),
            lineSeparatorTwo.leadingAnchor.constraint(equalTo: parentStackView.leadingAnchor),
            lineSeparatorTwo.trailingAnchor.constraint(equalTo: parentStackView.trailingAnchor),
            
            lineSeparatorThree.heightAnchor.constraint(equalToConstant: 1),
            lineSeparatorThree.leadingAnchor.constraint(equalTo: parentStackView.leadingAnchor),
            lineSeparatorThree.trailingAnchor.constraint(equalTo: parentStackView.trailingAnchor)
        ])
    }
    
    // настройка пикера пола
    private func createGenderToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelGender))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(selectGender))
        
        toolbar.setItems([cancelButton, spacer, doneButton], animated: true)
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    @objc func selectGender() {
        genderTextField.text = genderPickerView.selectedItem()
        genderTextField.endEditing(false)
    }
    
    @objc func cancelGender() {
        genderTextField.endEditing(false)
    }
    
    private func configureGenderTextField(textField: UITextField, toolbar: UIToolbar) {
        textField.inputView = genderPickerView
        textField.inputAccessoryView = toolbar
    }
}
