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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsToAdd
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuestionCell", for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
