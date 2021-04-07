//
//  AddQuestionViewController.swift
//  Millionaire
//
//  Created by Daniil Kniss on 07.04.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addQuestionButton: UIButton!
    var questionsToAdd = 1
    
    // MARK: IBActions
    
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addQuestion(_ sender: UIButton) {
        self.questionsToAdd += 1
        self.tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        tableView.backgroundColor = .clear
    }
    
    // MARK: Private functions
    
    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}

extension AddQuestionViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionsToAdd
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = configureCell(indexPath: indexPath)
        let cellColor = UIColor(white: 0.70,alpha: 0.3)
        cell.backgroundColor = cellColor
        return cell
    }
    
    private func configureCell(indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as? QuestionCell else { return defaultCell }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnswersCell", for: indexPath) as? AnswersCell else { return defaultCell }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectAnswerCell", for: indexPath) as? CorrectAnswerCell else { return defaultCell }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuestionCell", for: indexPath) as? AddQuestionCell else { return defaultCell }
            return cell
        default:
            return defaultCell
        }
        
    }
    
    
}
