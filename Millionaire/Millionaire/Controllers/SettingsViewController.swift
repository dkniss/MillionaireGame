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
        let alertVC = UIAlertController(title: "Успешно!", message: "Все ваши вопросы удалены", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default) { _ in
            Game.shared.clearQuestions()
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }
    
    // MARK: Private Methods
    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}
