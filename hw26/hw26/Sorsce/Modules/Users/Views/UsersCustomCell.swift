//
//  UsersCustomCell.swift
//  hw26
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation
import UIKit

class UsersCustomCell: UITableViewCell {
    
    static let cellUsersId = "cellUsersId"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: UsersCustomCell.cellUsersId)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupTable() {
        accessoryType = .disclosureIndicator
    }
}
