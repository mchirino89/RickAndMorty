//
//  NavigationTestCases.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 14/12/20.
//

import XCTest
@testable import R_M

final class NavigationTestCases: XCTestCase {
    var mockController: MainListViewController!
    var dummyNavigation: UINavigationController!
    var navigationSpy: CoordinatorSpy!
    var fakeInteractor: ListInteractorDummy!

    override func setUp() {
        super.setUp()
        navigationSpy = CoordinatorSpy()
        fakeInteractor = ListInteractorDummy()
    }

    override func tearDown() {
        super.tearDown()
        navigationSpy = nil
        mockController = nil
        dummyNavigation = nil
        fakeInteractor = nil
    }

    func testSelectedCharacterNavigation() {
        givenCoordinatorInitialSetup()
        whenCharacterIsSelected()
        thenVerifyNavigationOccurs()
    }
}

private extension NavigationTestCases {
    func givenCoordinatorInitialSetup() {
        mockController = MainListViewController(charactersRepo: CharacterRepoMockSuccess(),
                                                navigationListener: navigationSpy,
                                                cache: CacheableMock(),
                                                listListener: fakeInteractor)
        _ = mockController.view
    }

    func whenCharacterIsSelected() {
        mockController.didSelected(at: 0)
    }

    func thenVerifyNavigationOccurs() {
        XCTAssertEqual(navigationSpy.invokedCheckDetails, true)
    }
}
