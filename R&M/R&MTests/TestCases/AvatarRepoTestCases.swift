//
//  AvatarRepoTestCases.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 16/12/20.
//

import MauriNet
import XCTest
@testable import R_M

final class AvatarRepoTestCases: XCTestCase {
    var avatarRepo: ImagesStockable!
    var testExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        testExpectation = expectation(description: "API consumption expectation")
    }

    override func tearDown() {
        super.tearDown()
        avatarRepo = nil
        testExpectation = nil
    }

    func testAvatarRetrievalFromServer() {
        givenAvatarSetupForSuccess()
        whenAvatarIsRequested { [unowned self] result in
            self.thenVerifyProperDataForAvatarReceived(from: result)
        }
    }

    func testErrorHandlingForAvatarRepo() {
        givenAvatarSetupForFailure()
        whenAvatarIsRequested { [unowned self] result in
            self.thenVerifyProperErrorIsPropagated(from: result)
        }
    }
}

private extension AvatarRepoTestCases {
    func givenAvatarSetupForSuccess() {
        avatarRepo = AvatarRepoStubbedSuccess()
    }

    func givenAvatarSetupForFailure() {
        avatarRepo = AvatarRepoStubbedFailure()
    }

    func whenAvatarIsRequested(onCompletion: @escaping AvatarResult) {
        avatarRepo.avatar(from: URL(validURL: "avatar"), onCompletion: onCompletion)

        wait(for: [testExpectation], timeout: 0.1)
    }

    func thenVerifyProperDataForAvatarReceived(from result: Result<Data, NetworkError>) {
        switch result {
        case .success(let data):
            XCTAssertFalse(data.isEmpty)
            testExpectation.fulfill()
        case .failure(let receivedError):
            XCTFail("Success fake response shouldn't thrown this error \(receivedError.localizedDescription)")
            testExpectation.fulfill()
        }
    }

    func thenVerifyProperErrorIsPropagated(from result: Result<Data, NetworkError>) {
        switch result {
        case .success(let data):
            XCTFail("Failed request shouldn't produce a successful response with data = \(data.description)")
            testExpectation.fulfill()
        case .failure(let receivedError):
            XCTAssertEqual(receivedError, .notFound)
            testExpectation.fulfill()
        }
    }
}
