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
    
 
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var questionsCounter: UILabel!
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var answersSubviewA: UIStackView!
    @IBOutlet weak var answersSubviewB: UIStackView!
    @IBOutlet weak var answerA: UIButton! {
        didSet {
            answerA.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        }
    }
    @IBOutlet weak var answerB: UIButton! {
        didSet {
            answerB.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        }
    }
    @IBOutlet weak var answerC: UIButton! {
        didSet {
            answerC.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        }
    }
    @IBOutlet weak var answerD: UIButton! {
        didSet {
            answerD.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        }
    }
    
    @IBAction func exit(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    var questions = [
        Question(question: "Как называется популярный рецепт приготовления макарон с мясом?", answers: ["A":"По-деревенски","B":"По-флотски","C":"По-братски","D":"По-божески"], correctAnswer: "B"),
        Question(question: "Какой флаг развевается над пиратским судном?", answers: ["A":"Грустный Роберт","B":"Печальный Рональд","C":"Смешливый Роналд","D":"Веселый Роджер"], correctAnswer: "D"),
        Question(question: "Какой газ преобладает в атмосфере Земли?", answers: ["A":"Кислород","B":"Азот","C":"Углекислый газ","D":"Водород"], correctAnswer: "B"),
        Question(question: "Какой вид спорта не входит в современное пятиборье?", answers: ["A":"Метание копья","B":"Верховая езда","C":"Фехтование","D":"Плавание"], correctAnswer: "A"),
        Question(question: "Что является характеристикой коллекционного вина?", answers: ["A":"Стойкость","B":"Выдержка","C":"Выносливость","D":"Трезвость"], correctAnswer: "B")
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
        backgroundImage.image = UIImage(named: "startScreenBackground")
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
    
    @objc private func checkAnswer(_ sender: UIButton) {
        guard let currentQuestion = questions.filter({$0.question == question.text}).first else { return }
        let correctAnswer = currentQuestion.correctAnswer
        
        if sender.title(for: .normal) == correctAnswer + ": " + (currentQuestion.answers[correctAnswer] ?? "") {
            let alertVC = UIAlertController(title: "Правильно!", message: "Переходим к следующему вопросу", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.configureQuestion()
            })
            alertVC.addAction(action)
            present(alertVC, animated: true)
        } else {
            let alertVC = UIAlertController(title: "Неверно!", message: "Игра окончена", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .destructive, handler: { _ in
                self.delegate?.didEndGame(withResult: self.answersCount - 1, with: self.questions.count)
                self.dismiss(animated: true)
            })
            alertVC.addAction(action)
            present(alertVC, animated: true)
        }
    }
    
    private func endGame() {
        let alertVC = UIAlertController(title: "Игра окончена!", message: "Вы ответили на все вопросы", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.delegate?.didEndGame(withResult: self.answersCount - 1, with: self.questions.count)
            self.dismiss(animated: true)
        })
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}






