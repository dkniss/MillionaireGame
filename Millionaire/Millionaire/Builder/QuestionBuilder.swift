//
//  QuestionBuilder.swift
//  Millionaire
//
//  Created by Daniil Kniss on 08.04.2021.
//

import Foundation

class QuestionBuilder {
    private(set) var question = ""
    private(set) var answers = ["" : ""]
    private(set) var correctAnswer = ""
    
    func build() -> Question {
        return Question(question: question, answers: answers, correctAnswer: correctAnswer)
    }
    
    func setQuestion(_ question: String) {
        self.question = question
    }
    
    func setAnswers(_ answers: [String : String]) {
        self.answers = answers
    }
    
    func setCorrectAnswer(_ correctAnswer: String) {
        self.correctAnswer = correctAnswer
    }
}
