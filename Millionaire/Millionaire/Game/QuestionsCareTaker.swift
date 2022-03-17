//
//  QuestionsCareTaker.swift
//  Millionaire
//
//  Created by Daniil Kniss on 08.04.2021.
//

import Foundation

class QuestionsCareTaker {
    // MARK: - Properties
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    private let key = "questions"
    
    // MARK: - Methods
    func save(questions: [Question]) {
        do {
            let data = try self.encoder.encode(questions)
            UserDefaults.standard.set(data,forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieveQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let result = try self.decoder.decode([Question].self, from: data)
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
