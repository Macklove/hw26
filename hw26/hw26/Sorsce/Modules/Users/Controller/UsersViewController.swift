//
//  Controller.swift
//  hw26
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation
import UIKit

class UsersViewController: UIViewController {
    
    let customCellUsers = UsersCustomCell()
    let usersPresenter = UsersPresenter()
    let coreDataService = ServiceCoreData()
    
    private var userView: UsersView? {
        guard isViewLoaded else { return nil}
        return view as? UsersView
    }
    
    private var detailView: DetailInfoView? {
        guard isViewLoaded else { return nil}
        return view as? DetailInfoView
    }
    
    //MARK: Lifecikle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreDataService.saveContext()
        coreDataService.fetchData()
    }
    
    func setupView() {
        view = UsersView()
        userView?.tableView.dataSource = self
        userView?.tableView.delegate = self
    }
    
    func setupNavigation() {
        navigationItem.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setupAction() {
        userView?.buttonPress.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }
    
    @objc private func createButtonTapped() {
        if !(userView?.selfTextField.hasText ?? true) {
            showAlert(title: "Error", message: "Enter name")
        } else {
            reload()
            userView?.selfTextField.text = ""
            userView?.selfTextField.isSelected = false
        }
    }
    
    //MARK: CoreData
    private func reload() {
        coreDataService.save(userView?.selfTextField.text ?? "")
        userView?.tableView.insertRows(at: [IndexPath(row: coreDataService.users.count - 1, section: 0)], with: .automatic)
    }
    
    //MARK:  Alert
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Close", style: .cancel)
        alert.addAction(okButton)
        navigationController?.present(alert, animated: true)
    }
}

//MARK: extention
extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataService.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersCustomCell.cellUsersId, for: indexPath) as? UsersCustomCell else { return UITableViewCell()
        }
        cell.textLabel?.text = coreDataService.users[indexPath.row].name
        cell.setupTable()
        return cell
    }
    
    // deleting data
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let user = coreDataService.users[indexPath.row]
        if editingStyle == .delete {
            coreDataService.deleteUser(user, indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userPresenter = coreDataService.users[indexPath.row]
        
        let detailsVC = InfoUsersViewController()
        let presentrer = DetailsPresenter()
        
        presentrer.user = userPresenter
        detailsVC.presenter = presentrer
        
        navigationController?.pushViewController(detailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
