//
//  CharactersRepoTestCases.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 07/12/20.
//

import XCTest
@testable import R_M

final class CharactersRepoTestCases: XCTestCase {
    var fakeRequestManager: FakeRequestManagerSuccessResponse!
    var characterRepo: CharacterStoredRepo!
    var testExpectation: XCTestExpectation!

    override func tearDown() {
        super.tearDown()
        fakeRequestManager = nil
        characterRepo = nil
        testExpectation = nil
    }

    func testCharactersQueryFetch() {
        givenRepoWiringSetup()
        whenAllCharactersQueryIsExecuted { [unowned self] result in
            // Then
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 5)
                testExpectation.fulfill()
            case .failure:
                XCTFail("Success fake response shouldn't thrown an error")
                testExpectation.fulfill()
            }
        }
    }

    func testCharactersFilterQueryFetch() {
        givenRepoWiringSetup()
        whenFilteredCharactersQueryIsExecuted { [unowned self] result in
            // Then
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 6)
                XCTAssertEqual(characters.filter { $0.species.lowercased() == "human" }.count, 0)
                testExpectation.fulfill()
            case .failure:
                XCTFail("Success fake response shouldn't thrown an error")
                testExpectation.fulfill()
            }
        }
    }
}

private extension CharactersRepoTestCases {
    func givenRepoWiringSetup() {
        fakeRequestManager = FakeRequestManagerSuccessResponse()
        characterRepo = CharacterStoredRepo(networkService: fakeRequestManager)
        testExpectation = expectation(description: "API consumption expectation")
    }

    func whenAllCharactersQueryIsExecuted(onCompletion: @escaping CharacterResult) {
        characterRepo.allCharacters(onCompletion: onCompletion)

        wait(for: [testExpectation], timeout: 0.1)
    }

    func whenFilteredCharactersQueryIsExecuted(onCompletion: @escaping CharacterResult) {
        characterRepo.filteredCharacters(by: "species", onCompletion: onCompletion)

        wait(for: [testExpectation], timeout: 0.1)
    }
}
