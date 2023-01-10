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
    let isRecording: Bool = false
    var fakeController: UIViewController!
    var dummyCache: DummyCacheable!
    var stubbedCharactersRepo: CharacterRepoStubbedSuccess!
    var dummyNavigation: UINavigationController!

    override func setUp() {
        super.setUp()
        dummyCache = DummyCacheable()
        stubbedCharactersRepo = CharacterRepoStubbedSuccess()
    }

    override func tearDown() {
        super.tearDown()
        stubbedCharactersRepo = nil
        fakeController = nil
        dummyNavigation = nil
        dummyCache = nil
    }

    func testUILayoutForCharacterListingOnLightMode() {
        givenMockList()
        whenNavigationOccurs(on: .light)
        thenAssertProperRendering(on: #function)
    }

    func testUILayoutForDetailsRenderingOnLightMode() {
        givenMockDetails()
        whenNavigationOccurs(on: .light)
        thenAssertProperRendering(on: #function)
    }

    func testUILayoutForCharacterListingOnDarkMode() {
        givenMockList()
        whenNavigationOccurs(on: .dark)
        thenAssertProperRendering(on: #function)
    }

    func testUILayoutForDetailsRenderingOnDarkMode() {
        givenMockDetails()
        whenNavigationOccurs(on: .dark)
        thenAssertProperRendering(on: #function)
    }
}

private extension SnapshotTestCases {
    func givenMockList() {
        fakeController = MainListViewController(charactersRepo: stubbedCharactersRepo,
                                                navigationListener: CoordinatorSpy(),
                                                cache: DummyCacheable())
    }

    func givenMockDetails() {
        let mockCharacter: CharacterDTO = try! FileReader().decodeJSON(in: Bundle(for: Self.self), from: "Rick")
        fakeController = DetailsViewController(charactersRepo: stubbedCharactersRepo,
                                               currentCharacter: mockCharacter,
                                               cache: DummyCacheable())
    }

    func whenNavigationOccurs(on userInterfaceStyle: UIUserInterfaceStyle) {
        dummyNavigation = UINavigationController(rootViewController: fakeController)
        dummyNavigation.overrideUserInterfaceStyle = userInterfaceStyle
    }

    func thenAssertProperRendering(on scenario: String) {
        assertSnapshot(matching: dummyNavigation,
                       as: .image(on: .iPhone8),
                       record: isRecording,
                       testName: scenario)
    }
}
