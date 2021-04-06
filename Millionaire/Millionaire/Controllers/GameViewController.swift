//
//  GameViewController.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import UIKit

protocol GameViewControllerDelegate {
    func didEndGame(withResult result: Int,with questionsCount: Int)
}

class GameViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var questionsCounter: UILabel!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var answersSubviewA: UIStackView!
    @IBOutlet weak var answersSubviewB: UIStackView!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    
    // MARK: IBActions
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func buttonAPressed(_ sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func buttonBPressed(_ sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func buttonCPressed(_ sender: UIButton) {
        checkAnswer(sender)
    }
    @IBAction func buttonDPressed(_ sender: UIButton) {
        checkAnswer(sender)
    }
    
    var questions = [
        Question(question: "Как называется популярный рецепт приготовления макарон с мясом?", answers: ["A":"По-деревенски","B":"По-флотски","C":"По-братски","D":"По-божески"], correctAnswer: "B"),
        Question(question: "Какой флаг развевается над пиратским судном?", answers: ["A":"Грустный Роберт","B":"Печальный Рональд","C":"Смешливый Роналд","D":"Веселый Роджер"], correctAnswer: "D"),
        Question(question: "Какой газ преобладает в атмосфере Земли?", answers: ["A":"Кислород","B":"Азот","C":"Углекислый газ","D":"Водород"], correctAnswer: "B"),
        Question(question: "Какой вид спорта не входит в современное пятиборье?", answers: ["A":"Метание копья","B":"Верховая езда","C":"Фехтование","D":"Плавание"], correctAnswer: "A"),
        Question(question: "Что является характеристикой коллекционного вина?", answers: ["A":"Стойкость","B":"Выдержка","C":"Выносливость","D":"Трезвость"], correctAnswer: "B"),
        Question(question: "Какая из перечисленных башен самая низкая?", answers: ["A":"Останкинская","B":"Эйфелева","C":"Пизанская","D":"Спасская"], correctAnswer: "C")
    ]
    
    var answersCount = 0
    
    let gameSession = GameSession()
    
    var delegate: GameViewControllerDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.shared.gameSession = gameSession
        self.delegate = gameSession
        setupBackground()
        questions.shuffle()
        configureQuestion()
    }
    
    private func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func configureQuestion() {
        answersCount += 1
        
        if answersCount <= questions.count {
            
            questionsCounter.text = "Вопрос \(answersCount) из \(questions.count)"
            
            let currentQuestion = questions[answersCount - 1]
            question.text = currentQuestion.question
            answerA.setTitle("A: " + (currentQuestion.answers["A"] ?? ""), for: .normal)
            answerB.setTitle("B: " + (currentQuestion.answers["B"] ?? ""), for: .normal)
            answerC.setTitle("C: " + (currentQuestion.answers["C"] ?? ""), for: .normal)
            answerD.setTitle("D: " + (currentQuestion.answers["D"] ?? ""), for: .normal)
        } else {
            endGame()
        }
    }
    
    private func checkAnswer(_ sender: UIButton) {
        let currentQuestion = questions[answersCount - 1]
        let correctAnswer = currentQuestion.correctAnswer
        let answersDict = ["A":0,"B":1,"C":2,"D":3]
        
        if sender.tag == answersDict[correctAnswer] {
            let alertVC = UIAlertController(title: "Правильно!", message: "Переходим к следующему вопросу", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.configureQuestion()
            })
            alertVC.addAction(action)
            present(alertVC, animated: true)
        } else {
            endGame()
        }
    }
    
    private func endGame() {
        let title = "Игра окончена!"
        var message = ""
        
        if (self.answersCount - 1) < self.questions.count {
            message = "Вы ответили на \(self.answersCount - 1) из \(self.questions.count) вопросов"
        } else {
            message = "Вы ответили на все вопросы"
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.delegate?.didEndGame(withResult: self.answersCount - 1, with: self.questions.count)
            self.dismiss(animated: true)
        })
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}






