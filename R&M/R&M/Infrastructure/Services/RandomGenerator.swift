//
//  RandomGenerator.swift
//  R&M
//
//  Created by Mauricio Chirino on 9/1/23.
//

import Foundation

protocol Randomable {
    var totalPages: Int { get set }

    func produceRandomPage() -> String
}

struct RandomGenerator: Randomable {
    var totalPages: Int

    func produceRandomPage() -> String {
        return String(Int.random(in: 0...totalPages))
    }
}
