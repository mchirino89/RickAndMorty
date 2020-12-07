//
//  CharactersRepoTestCases.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 07/12/20.
//

import XCTest
@testable import R_M

final class CharactersRepoTestCases: XCTestCase {
    func testCharactersQueryFetch() {
        // Given
        let fakeRequestManager = FakeRequestManagerSuccessResponse()
        let characterRepo = CharacterStoredRepo(networkService: fakeRequestManager)
        let testExpectation = expectation(description: "API consumption expectation")

        // When
        characterRepo.allCharacters { result in
            switch result {
            case .success(let characters):
                XCTAssertNotEqual(characters.count, 0)
                testExpectation.fulfill()
            case .failure:
                XCTFail("Success fake response shouldn't thrown an error")
                testExpectation.fulfill()
            }
        }

        wait(for: [testExpectation], timeout: 0.1)
    }
}
