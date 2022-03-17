//
//  GameViewController.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func didEndGame(withResult result: Int, with questionsCount: Int)
}

class GameViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var questionsCounter: UILabel!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var answersSubviewA: UIStackView!
    @IBOutlet weak var answersSubviewB: UIStackView!
    @IBOutlet weak var answerA: UIButton!
    @IBOutlet weak var answerB: UIButton!
    @IBOutlet weak var answerC: UIButton!
    @IBOutlet weak var answerD: UIButton!
    
    // MARK: - Properties
    weak var delegate: GameViewControllerDelegate?
    
    // MARK: - Private properties
    private let gameSession = GameSession()
    private let answersDict = ["A":0,"B":1,"C":2,"D":3]
    private let userQuestions = Game.shared.questions
    private let gameQuestions = [
        Question(question: "Как называется популярный рецепт приготовления макарон с мясом?",
                 answers: ["A":"По-деревенски","B":"По-флотски","C":"По-братски","D":"По-божески"],
                 correctAnswer: "B"),
        Question(question: "Какой флаг развевается над пиратским судном?",
                 answers: ["A":"Грустный Роберт","B":"Печальный Рональд","C":"Смешливый Роналд","D":"Веселый Роджер"],
                 correctAnswer: "D"),
        Question(question: "Какой газ преобладает в атмосфере Земли?",
                 answers: ["A":"Кислород","B":"Азот","C":"Углекислый газ","D":"Водород"],
                 correctAnswer: "B"),
        Question(question: "Какой вид спорта не входит в современное пятиборье?",
                 answers: ["A":"Метание копья","B":"Верховая езда","C":"Фехтование","D":"Плавание"],
                 correctAnswer: "A"),
        Question(question: "Что является характеристикой коллекционного вина?",
                 answers: ["A":"Стойкость","B":"Выдержка","C":"Выносливость","D":"Трезвость"],
                 correctAnswer: "B"),
        Question(question: "Какая из перечисленных башен самая низкая?",
                 answers: ["A":"Останкинская","B":"Эйфелева","C":"Пизанская","D":"Спасская"],
                 correctAnswer: "C")
    ]
    
    private var questions = [Question]()
    private var shuffleQuestionsStrategy: QuestionsSequenceStrategy {
        if Game.shared.isQuestionsShuffled {
            return ShuffleQuestionsStrategy()
        } else {
            return NonShuffleQuestionsStrategy()
        }
    }
    
    // MARK: - IBActions
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.shared.gameSession = gameSession
        questions = gameQuestions + userQuestions
        delegate = gameSession
        setupBackground()
        prepareQuestions(questions: questions)
        configureQuestion()
        gameSession.correctAnswers.addObserver(self, options: [.initial, .new]) { (answersCount, _) in
            self.questionsCounter.text = "Вопрос \(answersCount) из \(self.questions.count)"
        }
    }
    
    // MARK:  Private methods    
    private func configureQuestion() {
        gameSession.correctAnswers.value += 1
        
        let answersCount = gameSession.correctAnswers.value
        
        if answersCount <= questions.count {
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
        let answersCount = gameSession.correctAnswers.value
        let currentQuestion = questions[answersCount - 1]
        let correctAnswer = currentQuestion.correctAnswer
        
        if sender.tag == answersDict[correctAnswer] {
            self.showAlert(title: "Правильно!", message: "Переходим к следующему вопросу") { [weak self] in
                guard let self = self else { return }
                self.configureQuestion()
            }
        } else {
            endGame()
        }
    }
    
    private func endGame() {
        let title = "Игра окончена!"
        var message = ""
        let answersCount = gameSession.correctAnswers.value
        
        if (answersCount - 1) < self.questions.count {
            message = "Вы ответили на \(answersCount - 1) из \(self.questions.count) вопросов"
        } else {
            message = "Вы ответили на все вопросы верно!"
        }
        
        self.showAlert(title: title, message: message) { [weak self] in
            guard let self = self else { return }
            self.delegate?.didEndGame(withResult: answersCount - 1, with: self.questions.count)
            self.dismiss(animated: true)
        }
    }
    
    private func prepareQuestions(questions: [Question]) {
        let preparedQuestions = self.shuffleQuestionsStrategy.processQuestions(questions)
        self.questions = preparedQuestions
    }
}
