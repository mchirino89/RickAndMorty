//
//  MainCoordinator.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import MauriUtils
import UIKit

protocol Coordinator {
    func start()
    func checkDetails(for selectedCharacter: CharacterDTO)
}

final class MainCoordinator {
    var mainNavigator: UINavigationController?
    var rootViewController: UIViewController?
    let characterRepo: CharacterStorable

    init(characterRepo: CharacterStorable) {
        self.characterRepo = characterRepo
    }
}

extension MainCoordinator: Coordinator {
    func start() {
        let mainListController = MainListViewController(charactersRepo: characterRepo, navigationListener: self)
        mainNavigator = UINavigationController(rootViewController: mainListController)

        rootViewController = mainNavigator
    }

    func checkDetails(for selectedCharacter: CharacterDTO) {
    }
}
