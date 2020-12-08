//
//  SceneDelegate.swift
//  R&M
//
//  Created by Mauricio Chirino on 06/12/20.
//

import UIKit

private var areTestsRunning: Bool {
    NSClassFromString("XCTest") != nil
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard !areTestsRunning else {
            return
        }

        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        let rootCoordinator = MainCoordinator()
        rootCoordinator.start()

        buildMainWindow(for: windowScene, with: rootCoordinator.rootViewController)
    }

    private func buildMainWindow(for windowScene: UIWindowScene, with rootController: UIViewController?) {
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}
