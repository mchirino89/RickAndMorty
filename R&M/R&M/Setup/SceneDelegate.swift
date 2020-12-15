//
//  SceneDelegate.swift
//  R&M
//
//  Created by Mauricio Chirino on 06/12/20.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        let rootCoordinator = MainCoordinator(characterRepo: CharacterStoredRepo())
        rootCoordinator.start()

        buildMainWindow(for: windowScene, with: rootCoordinator.rootViewController)
    }

    private func buildMainWindow(for windowScene: UIWindowScene, with rootController: UINavigationController?) {
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}
