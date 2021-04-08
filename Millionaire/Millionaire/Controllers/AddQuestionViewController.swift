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
    @IBOutlet weak var saveQuestionButton: UIButton!
    var questionsToAdd = 1
    
    // MARK: IBActions
    
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func addQuestion(_ sender: UIButton) {
        self.questionsToAdd += 1
        self.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: self.questionsToAdd - 1)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionsToAdd
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuestionCell", for: indexPath) as? AddQuestionCell else { return UITableViewCell() }
    
        let cellColor = UIColor(white: 0.7, alpha: 0.5)
        cell.backgroundColor = cellColor
        return cell
    }
}




