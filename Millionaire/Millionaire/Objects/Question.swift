//
//  Question.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import Foundation

struct Question: Codable {
    let question: String
    let answers: [String : String]
    let correctAnswer: String
}
