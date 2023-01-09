//
//  AppDelegate.swift
//  R&M
//
//  Created by Mauricio Chirino on 06/12/20.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let globalCache = CacheStore()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootCoordinator = MainCoordinator(characterRepo: CharacterStoredRepo(), cache: globalCache)
        rootCoordinator.start()

        buildMainWindow(with: rootCoordinator.rootViewController)

        return true
    }

    private func buildMainWindow(with rootController: UINavigationController?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}
