//
//  NavigationTestCases.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 14/12/20.
//

import XCTest
@testable import R_M

final class NavigationTestCases: XCTestCase {
    var mainCoordinator: MainCoordinator!
    var mockController: MainListViewController!
    var dummyNavigation: UINavigationController!
    var navigationSpy: CoordinatorSpy!

    override func setUp() {
        super.setUp()
        navigationSpy = CoordinatorSpy()
    }

    override func tearDown() {
        super.tearDown()
        mainCoordinator = nil
        mockController = nil
        dummyNavigation = nil
    }

//    func testSelectedCharacterNavigation() {
//        givenCoordinatorInitialSetup()
//        whenCharacterIsSelected()
//        thenVerifyNavigationOccurs()
//    }
}

private extension NavigationTestCases {
    func givenCoordinatorInitialSetup() {
        mockController = MainListViewController(charactersRepo: CharacterRepoMockSuccess(),
                                                navigationListener: navigationSpy)
    }

    func whenCharacterIsSelected() {
        mockController.collectionView(UICollectionView(), didSelectItemAt: IndexPath(item: 0, section: 0))
    }

    func thenVerifyNavigationOccurs() {
        XCTAssertEqual(navigationSpy.invokedCheckDetails, true)
    }
}
