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
    func testUILayoutForCharacterListing() {
        // Given
        let mockCharacter: CharacterDTO = try! FileReader().decodeJSON(from: "Rick")
        let mockController = MainListViewController(viewModel: CharacterViewModel(character: mockCharacter))

        // When
        let dummyNavigation = UINavigationController(rootViewController: mockController)

        // Then
        assertSnapshot(matching: dummyNavigation, as: .image(on: .iPhone8))
    }

    func testUILayoutForDetailsRendering() {
        // Given
        let mockCharacter: CharacterDTO = try! FileReader().decodeJSON(from: "Rick")
        let mockController = DetailsViewController(viewModel: CharacterViewModel(character: mockCharacter))

        // When
        let dummyNavigation = UINavigationController(rootViewController: mockController)

        // Then
        assertSnapshot(matching: dummyNavigation, as: .image(on: .iPhone8))
    }
}
