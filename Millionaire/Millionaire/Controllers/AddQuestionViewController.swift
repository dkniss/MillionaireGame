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
    var questionsToSave = [Question]()
    var keyboardDismissTapGesture: UIGestureRecognizer?
    
    // MARK: IBActions
    
    @IBAction func exit(_ sender: UIButton) {
        if questionsToSave.isEmpty {
            self.dismiss(animated: true)
        } else {
            let alertVC = UIAlertController(title: "Title", message: "Message", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "Cохранить", style: .default) { _ in
                self.dismiss(animated: true)
            }
            alertVC.addAction(action)
            self.present(alertVC, animated: true)
        }
        
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name:UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        
        super.viewWillDisappear(animated)
    }
    
    // MARK: Private functions
    
    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if keyboardDismissTapGesture == nil {
            keyboardDismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
            keyboardDismissTapGesture?.cancelsTouchesInView = false
            self.view.addGestureRecognizer(keyboardDismissTapGesture!)
        }
    }
    
    @objc private func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
            if keyboardDismissTapGesture != nil {
                self.view.removeGestureRecognizer(keyboardDismissTapGesture!)
                keyboardDismissTapGesture = nil
            }
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
    
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddQuestionCell", for: indexPath) as? AddQuestionCell
        else { return UITableViewCell() }
    
        let cellColor = UIColor(white: 0.7, alpha: 0.5)
        cell.backgroundColor = cellColor
        return cell
    }
}




