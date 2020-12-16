//
//  SnapshotTestCases.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 13/12/20.
//

import MauriUtils
import SnapshotTesting
import XCTest
@testable import R_M

final class SnapshotTestCases: XCTestCase {
    var mockController: UIViewController!
    var mockCache: CacheableMock!
    var charactersRepo: CharacterRepoMockSuccess!
    var dummyNavigation: UINavigationController!

    override func setUp() {
        super.setUp()
        mockCache = CacheableMock()
        charactersRepo = CharacterRepoMockSuccess()
    }

    override func tearDown() {
        super.tearDown()
        charactersRepo = nil
        mockController = nil
        dummyNavigation = nil
        mockCache = nil
    }

    func testUILayoutForCharacterListing() {
        givenMockList()
        whenNavigationOccurs()
        thenAssertProperRendering(on: #function)
    }

    func testUILayoutForDetailsRendering() {
        givenMockDetails()
        whenNavigationOccurs()
        thenAssertProperRendering(on: #function)
    }
}

private extension SnapshotTestCases {
    func givenMockList() {
        mockController = MainListViewController(charactersRepo: charactersRepo,
                                                navigationListener: CoordinatorSpy(),
                                                cache: CacheableMock())
    }

    func givenMockDetails() {
        let mockCharacter: CharacterDTO = try! FileReader().decodeJSON(in: Bundle(for: Self.self), from: "Rick")
        mockController = DetailsViewController(charactersRepo: charactersRepo,
                                               currentCharacter: mockCharacter,
                                               cache: CacheableMock())
    }

    func whenNavigationOccurs() {
        dummyNavigation = UINavigationController(rootViewController: mockController)
    }

    func thenAssertProperRendering(on scenario: String) {
        assertSnapshot(matching: dummyNavigation, as: .image(on: .iPhone8), testName: scenario)
    }
}
