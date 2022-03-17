//
//  RecordsCareTaker.swift
//  Millionaire
//
//  Created by Daniil Kniss on 04.04.2021.
//

import Foundation

class RecordsCareTaker {
    // MARK: - Properties
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    private let key = "records"

    // MARK: - Methods
    func save(records: [Record]) {
        do {
            let data = try self.encoder.encode(records)
            UserDefaults.standard.set(data,forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func retrieveRecords() -> [Record] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let result = try self.decoder.decode([Record].self, from: data)
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
