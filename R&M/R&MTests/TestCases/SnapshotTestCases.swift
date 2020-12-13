//
//  SnapshotTestCases.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 13/12/20.
//

import SnapshotTesting
import XCTest
@testable import R_M

final class SnapshotTestCases: XCTestCase {
    func testUILayoutForCharacterListing() {
        // Given
        let mockController = MainListViewController(viewModel: MainListViewModel())

        // When
        let dummyNavigation = UINavigationController(rootViewController: mockController)

        // Then
        assertSnapshot(matching: dummyNavigation, as: .image(on: .iPhone8))
    }
}
