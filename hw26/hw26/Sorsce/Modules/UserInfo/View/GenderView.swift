//
//  GenderView.swift
//  hw26
//
//  Created by Евгений Макулов on 26.08.2022.
//

import Foundation
import UIKit

private enum Genders: String, CaseIterable {
    case man = "Men"
    case women = "Women"
}

class GenderView: UIPickerView {
    
    // инициализация
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        delegate = self
        dataSource = self
    }

    func selectedItem() -> String {
        let item = selectedRow(inComponent: 0)
        return Genders.allCases[item].rawValue
    }
}

extension GenderView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Genders.allCases[row].rawValue
    }
}

extension GenderView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Genders.allCases.count
    }
}
