//
//  GameSession.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import Foundation

protocol GameSessionDelegate: class {
    func didEndGame(with result: Int)
}


class GameSession {
 
    var correctAnswers = 0
    
    weak var delegate: GameSessionDelegate?

}

extension GameSession: GameSessionDelegate {
    func didEndGame(with result: Int) {
        self.correctAnswers = result
        print(correctAnswers)
    }
    
    
}


