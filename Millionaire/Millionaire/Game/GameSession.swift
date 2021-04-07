//
//  GameSession.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import Foundation

class GameSession {
    var correctAnswers = Observable<Int>(0)
    var questionsCount = 0
}

extension GameSession: GameViewControllerDelegate {
    func didEndGame(withResult result: Int,with questionsCount: Int) {
        self.correctAnswers.value = result
        self.questionsCount = questionsCount

        let scoreInPercents = round((Double(result) / Double(questionsCount)) * 100.0)
      
        let record = Record(score: result, questionsCount: questionsCount, date: Date(), scoreInPercents: scoreInPercents)
        
        Game.shared.addRecord(record)
        Game.shared.gameSession = nil
    }
}



