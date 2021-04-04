//
//  GameSession.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import Foundation

class GameSession {
    var correctAnswers = 0
    var questionsCount = 0

}

extension GameSession: GameViewControllerDelegate {
    func didEndGame(withResult result: Int,with questionsCount: Int) {
        self.correctAnswers = result
        self.questionsCount = questionsCount
        let record = Record(score: result, questionsCount: questionsCount, date: Date())
        Game.shared.addRecord(record)
        Game.shared.gameSession = nil
    }
    
    
}



