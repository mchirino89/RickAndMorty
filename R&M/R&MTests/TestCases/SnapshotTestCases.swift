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
    var dummyNavigation: UINavigationController!

    override func tearDown() {
        super.tearDown()
        mockController = nil
        dummyNavigation = nil
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
        let mockCharacter: CharacterDTO = try! FileReader().decodeJSON(from: "Rick")
        mockController = MainListViewController(viewModel: CharacterViewModel(character: mockCharacter))
    }

    func givenMockDetails() {
        let mockCharacter: CharacterDTO = try! FileReader().decodeJSON(from: "Rick")
        mockController = DetailsViewController(viewModel: CharacterViewModel(character: mockCharacter))
    }

    func whenNavigationOccurs() {
        dummyNavigation = UINavigationController(rootViewController: mockController)
    }

    func thenAssertProperRendering(on scenario: String) {
        assertSnapshot(matching: dummyNavigation, as: .image(on: .iPhone8), testName: scenario)
    }
}
