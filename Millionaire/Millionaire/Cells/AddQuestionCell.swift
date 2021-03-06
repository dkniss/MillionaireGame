//
//  AddQuestionCell.swift
//  Millionaire
//
//  Created by Daniil Kniss on 07.04.2021.
//

import UIKit

class AddQuestionCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var labelB: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelD: UILabel!
    @IBOutlet weak var textFieldA: UITextField!
    @IBOutlet weak var textFieldB: UITextField!
    @IBOutlet weak var textFieldC: UITextField!
    @IBOutlet weak var textFieldD: UITextField!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var correctAnswerPicker: UIPickerView!
    
    // MARK: - Private properties
    private let numberOfComponents = 1
    private let numberOfRows = 4
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.correctAnswerPicker.delegate = self
        self.correctAnswerPicker.dataSource = self
        self.questionTextField.delegate = self
        self.textFieldA.delegate = self
        self.textFieldB.delegate = self
        self.textFieldC.delegate = self
        self.textFieldD.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension AddQuestionCell: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
   }
}

extension AddQuestionCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        self.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.numberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "?????????????? A"
        case 1:
            return "?????????????? B"
        case 2:
            return "?????????????? C"
        case 3:
            return "?????????????? D"
        default:
            return ""
        }
    }
}
