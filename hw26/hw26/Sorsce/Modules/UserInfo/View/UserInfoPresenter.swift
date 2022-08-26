//
//  UserInfoPresenter.swift
//  hw26
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation

class DetailsPresenter {
    
   let coreDataService = ServiceCoreData()
   var user = Person()
    
    func updateUser(_ user: Person, gender: String?, date: Date) {
        coreDataService.updateUser(user, gender: gender, date: date)
    }
}
