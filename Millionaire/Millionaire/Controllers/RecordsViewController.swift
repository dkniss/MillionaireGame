//
//  RecordsViewController.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import UIKit

class RecordsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }

    
    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "startScreenBackground")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Game.shared.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell",for: indexPath)
        
        let currentRecord = Game.shared.records[indexPath.row]
        
        cell.textLabel?.text = "Результат: \(currentRecord.score)/\(currentRecord.questionsCount)"
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: currentRecord.date, dateStyle: .short, timeStyle: .short)
        
        return cell
    }
    
    
}
