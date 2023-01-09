//
//  StubbedRandomGenerator.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 9/1/23.
//

@testable import R_M

struct StubbedRandomGenerator: Randomable {
    var totalPages: Int = 0

    func produceRandomPage() -> String {
        "3"
    }
}
