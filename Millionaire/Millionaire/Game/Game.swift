//
//  Game.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import Foundation

struct Record: Codable {
    let score: Int
    let questionsCount: Int
    let date: Date
    var scoreInPercents: Double 
}

class Game {
    
    static let shared = Game()
    
    weak var gameSession: GameSession?
    
    var questions = [
        Question(question: "Как называется популярный рецепт приготовления макарон с мясом?", answers: ["A":"По-деревенски","B":"По-флотски","C":"По-братски","D":"По-божески"], correctAnswer: "B"),
        Question(question: "Какой флаг развевается над пиратским судном?", answers: ["A":"Грустный Роберт","B":"Печальный Рональд","C":"Смешливый Роналд","D":"Веселый Роджер"], correctAnswer: "D"),
        Question(question: "Какой газ преобладает в атмосфере Земли?", answers: ["A":"Кислород","B":"Азот","C":"Углекислый газ","D":"Водород"], correctAnswer: "B"),
        Question(question: "Какой вид спорта не входит в современное пятиборье?", answers: ["A":"Метание копья","B":"Верховая езда","C":"Фехтование","D":"Плавание"], correctAnswer: "A"),
        Question(question: "Что является характеристикой коллекционного вина?", answers: ["A":"Стойкость","B":"Выдержка","C":"Выносливость","D":"Трезвость"], correctAnswer: "B"),
        Question(question: "Какая из перечисленных башен самая низкая?", answers: ["A":"Останкинская","B":"Эйфелева","C":"Пизанская","D":"Спасская"], correctAnswer: "C")
    ]
    
    var isQuestionsShuffled: Bool {
        guard let isShuffled = UserDefaults.standard.value(forKey: "switchOn") as? Bool else {return false}
        return isShuffled
    }
    
    private(set) var records: [Record] {
        didSet {
            recordsCaretaker.save(records: self.records)
        }
    }
    
    private let recordsCaretaker = RecordsCareTaker()
    
    func addRecord(_ record: Record) {
        self.records.append(record)
    }
    
    func clearRecords() {
        self.records = []
    }
    
    
    private init() {
        self.records = self.recordsCaretaker.retrieveRecords()
    }
    
}

    
    

