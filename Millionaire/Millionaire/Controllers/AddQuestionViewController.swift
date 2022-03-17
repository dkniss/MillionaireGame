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
    
    // MARK: - Properties
    private var questionsToAdd = 1
    private var questionsCells = [AddQuestionCell]()
    private var questionsToSave = [Question]()
    private var keyboardDismissTapGesture: UIGestureRecognizer?
    
    // MARK: IBActions
    @IBAction func exit(_ sender: UIButton) {
        if questionsCells.isEmpty {
            self.dismiss(animated: true)
        } else {
            let alertVC = UIAlertController(title: "Хотите выйти?",
                                            message: "У вас остались несохраненные вопросы",
                                            preferredStyle: .actionSheet)
            
            let saveAction = UIAlertAction(title: "Cохранить", style: .default) { [weak self] _ in
                guard let self = self else { return }
                self.saveQuestions()
                self.questionsToSave.forEach { question in
                    Game.shared.addQuestion(question)
                }
                self.questionsToSave.removeAll()
                self.questionsCells.removeAll()
                self.dismiss(animated: true)
            }
            let cancelAction = UIAlertAction(title: "Выйти", style: .destructive,handler: { _ in
                self.dismiss(animated: true)
            })
            alertVC.addAction(saveAction)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true)
        }
    }
    
    @IBAction func saveQuestionsButtonPressed(_ sender: UIButton) {
        self.saveQuestions()
        self.questionsToSave.forEach { question in
            Game.shared.addQuestion(question)
        }
        self.questionsToSave.removeAll()
        self.questionsCells.removeAll()
        self.questionsToAdd = 0
        self.tableView.reloadData()
        self.showAlert(title: "Успешно!", message: "Ваши вопросы сохранены", completion: nil)
    }
    
    @IBAction func addQuestion(_ sender: UIButton) {
        self.questionsToAdd += 1
        self.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: self.questionsToAdd - 1)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Private methods
    private func saveQuestions() {
        questionsCells.forEach { cell in
            let builder = QuestionBuilder()
            
            guard let question = cell.questionTextField.text else { return }
            
            guard
                let answerA = cell.textFieldA.text,
                let answerB = cell.textFieldB.text,
                let answerC = cell.textFieldC.text,
                let answerD = cell.textFieldD.text
            else { return }
            
            let answers = ["A":answerA, "B":answerB, "C":answerC, "D":answerD]
    
            let selectedPickerRow = cell.correctAnswerPicker.selectedRow(inComponent: 0)
            
            var correctAnswer: String {
                switch selectedPickerRow {
                case 0:
                    return "A"
                case 1:
                    return "B"
                case 2:
                    return "C"
                case 3:
                    return "D"
                default:
                    return ""
                }
            }
            
            guard
                question != "",
                correctAnswer != ""
            else {
                showError()
                return
            }
            
            guard !(question.isEmpty && correctAnswer.isEmpty) else {
                showError()
                return
            }
            
            answers.forEach { (key,value) in
                guard !(key.isEmpty && value.isEmpty) else {
                    showError()
                    return
                }
            }
            
            builder.setQuestion(question)
            builder.setAnswers(answers)
            builder.setCorrectAnswer(correctAnswer)
            self.questionsToSave.append(builder.build())
        }
    }
    
    private func showError() {
        let alertVC = UIAlertController(title: "Ошибка!", message: "Данные внесены некорректно" , preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .destructive)
        alertVC.addAction(action)
        self.present(alertVC, animated: true)
        
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if keyboardDismissTapGesture == nil {
            keyboardDismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
            keyboardDismissTapGesture?.cancelsTouchesInView = false
            self.view.addGestureRecognizer(keyboardDismissTapGesture!)
            let indexPath = IndexPath(row: 0, section: self.questionsToAdd - 1)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
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
        self.questionsCells.append(cell)
        return cell
    }
}
