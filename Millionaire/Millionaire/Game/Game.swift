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
}

class Game {
    
    static let shared = Game()
    
    weak var gameSession: GameSession?
    
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

    
    

