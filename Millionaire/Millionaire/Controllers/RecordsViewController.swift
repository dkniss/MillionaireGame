//
//  RecordsViewController.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import UIKit

class RecordsViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: IBActions
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        tableView.backgroundColor = .clear
    }
    
    // MARK: Private methods
   
}

// MARK: - TableView
extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell",for: indexPath)
        
        let currentRecord = Game.shared.records[indexPath.row]
        
        cell.textLabel?.text = "Результат: \(currentRecord.score)/\(currentRecord.questionsCount) (\(currentRecord.scoreInPercents)%)"
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: currentRecord.date, dateStyle: .short, timeStyle: .short)
        cell.backgroundColor = .clear
        
        return cell
    }
}
