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
    var mockController: UIViewController!
    var mockCache: DummyCacheable!
    var charactersRepo: CharacterRepoStubbedSuccess!
    var dummyNavigation: UINavigationController!

    override func setUp() {
        super.setUp()
        mockCache = DummyCacheable()
        charactersRepo = CharacterRepoStubbedSuccess()
    }

    override func tearDown() {
        super.tearDown()
        charactersRepo = nil
        mockController = nil
        dummyNavigation = nil
        mockCache = nil
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
}

private extension SnapshotTestCases {
    func givenMockList() {
        mockController = MainListViewController(charactersRepo: charactersRepo,
                                                navigationListener: CoordinatorSpy(),
                                                cache: DummyCacheable())
    }

    func givenMockDetails() {
        let mockCharacter: CharacterDTO = try! FileReader().decodeJSON(in: Bundle(for: Self.self), from: "Rick")
        mockController = DetailsViewController(charactersRepo: charactersRepo,
                                               currentCharacter: mockCharacter,
                                               cache: DummyCacheable())
    }

    func whenNavigationOccurs(on userInterfaceStyle: UIUserInterfaceStyle) {
        dummyNavigation = UINavigationController(rootViewController: mockController)
        dummyNavigation.overrideUserInterfaceStyle = userInterfaceStyle
    }

    func thenAssertProperRendering(on scenario: String) {
        assertSnapshot(matching: dummyNavigation,
                       as: .image(on: .iPhone8),
                       record: isRecording,
                       testName: scenario)
    }
}
