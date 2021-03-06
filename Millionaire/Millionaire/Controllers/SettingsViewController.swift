//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Daniil Kniss on 07.04.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var shuffleQuestionsLabel: UILabel!
    @IBOutlet weak var clearMyQuestionsLabel: UILabel!
    @IBOutlet weak var clearMyQuestionsButton: UIButton!
    @IBOutlet weak var shuffleQuestionsSwitch: UISwitch! {
        didSet {
            if Game.shared.isQuestionsShuffled {
                shuffleQuestionsSwitch.setOn(true, animated: true)
            } else {
                shuffleQuestionsSwitch.setOn(false, animated: true)
            }
        }
    }
    
    // MARK: IBActions
    @IBAction func shuffleQuestions(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.setValue(true, forKey: "switchOn")
        } else {
            UserDefaults.standard.setValue(false, forKey: "switchOn")
        }
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func clearMyQuestions(_ sender: Any) {
        self.showAlert(title: "Успешно!", message: "Все ваши вопросы удалены") {
            Game.shared.clearQuestions()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }
}
