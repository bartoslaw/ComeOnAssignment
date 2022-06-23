//
//  JSONLoader.swift
//  ComeOn AssignmentTests
//
//  Created by Bartłomiej Smektała on 23/06/2022.
//

import Foundation

final class JSONLoader {
    static func loadJson(fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
