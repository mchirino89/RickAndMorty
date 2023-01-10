//
//  NavigationTestCases.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 14/12/20.
//

import XCTest
@testable import R_M

final class NavigationTestCases: XCTestCase {
    var fakeController: MainListViewController!
    var navigationSpy: CoordinatorSpy!

    override func setUp() {
        super.setUp()
        navigationSpy = CoordinatorSpy()
    }

    override func tearDown() {
        super.tearDown()
        navigationSpy = nil
        fakeController = nil
    }

    func testSelectedCharacterNavigation() {
        givenCoordinatorInitialSetup()
        whenCharacterIsSelected()
        thenVerifyNavigationOccurs()
    }
}

private extension NavigationTestCases {
    func givenCoordinatorInitialSetup() {
        fakeController = MainListViewController(charactersRepo: CharacterRepoStubbedSuccess(),
                                                navigationListener: navigationSpy,
                                                cache: DummyCacheable(),
                                                listListener: ListInteractorDummy())
        fakeController.loadViewIfNeeded()
    }

    func whenCharacterIsSelected() {
        fakeController.didSelected(at: 0)
    }

    func thenVerifyNavigationOccurs() {
        XCTAssertEqual(navigationSpy.invokedCheckDetails, true)
    }
}
