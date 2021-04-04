//
//  GameSession.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import Foundation

class GameSession {
    var correctAnswers = 0

}

extension GameSession: GameViewControllerDelegate {
    func didEndGame(withResult result: Int) {
        self.correctAnswers = result
    }
    
    
}



