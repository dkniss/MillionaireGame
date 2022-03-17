//
//  QuestionsSequenceStrategy.swift
//  Millionaire
//
//  Created by Daniil Kniss on 07.04.2021.
//

import Foundation

protocol QuestionsSequenceStrategy {
    func processQuestions(_ question:[Question]) -> [Question]
}

class ShuffleQuestionsStrategy: QuestionsSequenceStrategy {
    func processQuestions(_ question: [Question]) -> [Question] {
        let shuffledQuestions = question.shuffled()
        return shuffledQuestions
    }
}

class NonShuffleQuestionsStrategy: QuestionsSequenceStrategy {
    func processQuestions(_ question: [Question]) -> [Question] {
        return question
    }
}
