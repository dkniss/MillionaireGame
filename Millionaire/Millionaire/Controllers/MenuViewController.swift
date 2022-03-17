//
//  MenuViewController.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import UIKit

class MenuViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var addQuestion: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "startGameSegue" else { return }
    }
}
