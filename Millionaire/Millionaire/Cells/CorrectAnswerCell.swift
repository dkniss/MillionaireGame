//
//  CorrectAnswerCell.swift
//  Millionaire
//
//  Created by Daniil Kniss on 07.04.2021.
//

import UIKit

class CorrectAnswerCell: UITableViewCell {
    
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var correctAnswerPicker: UIPickerView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.correctAnswerPicker.delegate = self
        self.correctAnswerPicker.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CorrectAnswerCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Вариант A"
        case 1:
            return "Вариант B"
        case 2:
            return "Вариант C"
        case 3:
            return "Вариант D"
        default:
            return ""
        }
    }
}
