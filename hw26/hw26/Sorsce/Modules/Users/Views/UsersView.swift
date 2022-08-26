//
//  UsersView.swift
//  hw26
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation
import UIKit

class UsersView: UIView {
    
    var selfTextField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.placeholder = "print your here name"
        return textField
    }()
    
    var buttonPress: UIButton = {
        var button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Press"
        button.configuration = config
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0, green: 0.477409184, blue: 1, alpha: 1)
        return button
    }()
    
    private lazy var userStackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        backgroundColor = .white
        setupView()
        addStackView()
        setupLoyaut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: bounds, style: .insetGrouped)
        table.register(UsersCustomCell.self, forCellReuseIdentifier: UsersCustomCell.cellUsersId)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func setupView() {
        addSubview(selfTextField)
        addSubview(buttonPress)
        addSubview(userStackView)
        addSubview(tableView)
    }
    
    private func addStackView() {
        userStackView.addArrangedSubview(selfTextField)
        userStackView.addArrangedSubview(buttonPress)
    }
    
    func setupLoyaut() {
        
        NSLayoutConstraint.activate([
            userStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            userStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            userStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: userStackView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
