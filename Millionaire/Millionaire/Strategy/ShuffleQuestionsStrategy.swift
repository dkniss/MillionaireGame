//
//  ShuffleQuestionsStrategy.swift
//  Millionaire
//
//  Created by Daniil Kniss on 07.04.2021.
//

import Foundation

protocol ShuffleStrategy {
    func shuffleQuestions(question:[Question]) -> [Question]
}

class ShuffleQuestionsStrategy: ShuffleStrategy {
    
    func shuffleQuestions(question: [Question]) -> [Question] {
        let shuffledQuestions = question.shuffled()
        return shuffledQuestions
    }
}

class NonShuffleQuestionsStrategy: ShuffleStrategy {
    
    func shuffleQuestions(question: [Question]) -> [Question] {
        return question
    }
}

