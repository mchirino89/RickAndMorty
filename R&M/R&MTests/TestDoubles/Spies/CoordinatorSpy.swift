//
//  CoordinatorSpy.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation
@testable import R_M

final class CoordinatorSpy: Coordinator {
    var invokedStart = false
    var invokedStartCount = 0

    func start() {
        invokedStart = true
        invokedStartCount += 1
    }

    var invokedCheckDetails = false
    var invokedCheckDetailsCount = 0
    var invokedCheckDetailsParameters: CacheSourceable?

    func checkDetails(for selectedCharacter: CacheSourceable) {
        invokedCheckDetails = true
        invokedCheckDetailsCount += 1
        invokedCheckDetailsParameters = selectedCharacter
    }
}
