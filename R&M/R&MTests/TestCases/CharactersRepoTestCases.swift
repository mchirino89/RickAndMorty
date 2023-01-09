//
//  CharactersRepoTestCases.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 07/12/20.
//

import MauriNet
import XCTest
@testable import R_M

final class CharactersRepoTestCases: XCTestCase {
    var characterRepo: CharacterStoredRepo!
    var testExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        testExpectation = expectation(description: "API consumption expectation")
    }

    override func tearDown() {
        super.tearDown()
        characterRepo = nil
        testExpectation = nil
    }

    func testCharactersQueryFetch() {
        givenRepoWiringSetup()
        whenAllCharactersQueryIsExecuted { [unowned self] result in
            self.thenVerifyProperCharacterRetrieval(from: result, totalCharacters: 5)
        }
    }

    func testCharactersFilterQueryFetch() {
        givenRepoWiringSetup()
        whenFilteredCharactersQueryIsExecuted { [unowned self] result in
            self.thenVerifyProperFilteredCharacterRetrieval(from: result, totalCharacters: 6)
        }
    }

    func testProperErrorHandlingWhenTheAPIReturnsCorruptedData() {
        givenRepoWiringSetupWithBadData()
        whenAllCharactersQueryIsExecuted { [unowned self] result in
            self.thenVerifyProperErrorIsCaught(from: result, errorType: .conflictOnResource)
        }
    }

    func testProperErrorHandlingWhenServerIsDown() {
        givenRepoWiringSetupWithUnreliableServer()
        whenAllCharactersQueryIsExecuted { [unowned self] result in
            self.thenVerifyProperErrorIsCaught(from: result, errorType: .serverDown)
        }
    }
}

private extension CharactersRepoTestCases {
    func givenRepoWiringSetup() {
        characterRepo = CharacterStoredRepo(networkService: FakeRequestManagerSuccessResponse())
    }

    func givenRepoWiringSetupWithBadData() {
        characterRepo = CharacterStoredRepo(networkService: ParserRequestManagerStubbedFailure())
    }

    func givenRepoWiringSetupWithUnreliableServer() {
        characterRepo = CharacterStoredRepo(networkService: NetworkConnectionRequestManagerStubbedFailure())
    }

    func whenAllCharactersQueryIsExecuted(onCompletion: @escaping CharacterResult) {
        characterRepo.allCharacters(onCompletion: onCompletion)

        wait(for: [testExpectation], timeout: 10)
    }

    func whenFilteredCharactersQueryIsExecuted(onCompletion: @escaping CharacterResult) {
        characterRepo.filteredCharacters(by: "species", onCompletion: onCompletion)

        wait(for: [testExpectation], timeout: 10)
    }

    func thenVerifyProperCharacterRetrieval(from result: Result<[CharacterDTO], Error>, totalCharacters: Int) {
        switch result {
        case .success(let characters):
            XCTAssertEqual(characters.count, totalCharacters)
        case .failure:
            XCTFail("Success fake response shouldn't thrown an error")
        }
        testExpectation.fulfill()
    }

    func thenVerifyProperFilteredCharacterRetrieval(from result: Result<[CharacterDTO], Error>,
                                                    totalCharacters: Int) {
        switch result {
        case .success(let characters):
            XCTAssertEqual(characters.count, totalCharacters)
            XCTAssertEqual(characters.filter { $0.species.lowercased() == "human" }.count, 0)
        case .failure:
            XCTFail("Success fake response shouldn't thrown an error")
        }
        testExpectation.fulfill()
    }

    func thenVerifyProperErrorIsCaught(from result: Result<[CharacterDTO], Error>, errorType: NetworkError) {
        switch result {
        case .success:
            XCTFail("Failure in parsing data shouldn't provide a successful response")
        case .failure(let receivedError):
            XCTAssertEqual(receivedError as? NetworkError, errorType)
        }
        testExpectation.fulfill()
    }
}
