//
//  UsersPresenter.swift
//  hw26
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation

class UsersPresenter {
    
    var users: [Person] = []
    
    func saveContext() {
        ServiceCoreData.shared.saveContext()
    }

    func fetchData() {
        ServiceCoreData.shared.fetchData()
    }
    
    func save(_ nameUser: String) {
        ServiceCoreData.shared.save(nameUser)
    }
    
    func deleteUser(_ user: Person, indexPath: IndexPath) {
        ServiceCoreData.shared.deleteUser(user, indexPath: indexPath)
    }
}
