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
    @IBOutlet weak var shuffleQuestionsSwitch: UISwitch! {
        didSet {
            switch Game.shared.isQuestionsShuffled {
            case true:
                shuffleQuestionsSwitch.setOn(true, animated: true)
            case false:
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }
    
    // MARK: Private functions
    
    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }

}
