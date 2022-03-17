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
    // MARK: - Properties
    static let shared = Game()
    
    var gameSession: GameSession?
    
    var isQuestionsShuffled: Bool {
        guard let isShuffled = UserDefaults.standard.value(forKey: "switchOn") as? Bool else {return false}
        return isShuffled
    }
    
    // MARK: - Private properties
    private(set) var questions: [Question] {
        didSet {
            questionsCaretaker.save(questions: questions)
        }
    }
    
    private(set) var records: [Record] {
        didSet {
            recordsCaretaker.save(records: self.records)
        }
    }
    
    private let recordsCaretaker = RecordsCareTaker()
    private let questionsCaretaker = QuestionsCareTaker()
    
    // MARK: - Init
    private init() {
        self.records = self.recordsCaretaker.retrieveRecords()
        self.questions = self.questionsCaretaker.retrieveQuestions()
    }
    
    // MARK: - Methods
    func addRecord(_ record: Record) {
        self.records.append(record)
    }
    
    func clearRecords() {
        self.records = []
    }
    
    func addQuestion(_ question: Question) {
        self.questions.append(question)
    }
    
    func clearQuestions() {
        self.questions = []
    }
}

    
    

