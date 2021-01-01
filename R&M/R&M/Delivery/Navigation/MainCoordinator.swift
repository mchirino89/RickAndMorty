//
//  MainCoordinator.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import UIKit

protocol Coordinator {
    func start()
    func checkDetails(for selectedCharacter: CharacterDTO)
}

final class MainCoordinator {
    var rootViewController: UINavigationController
    let characterRepo: CharacterStorable
    let cache: Cacheable

    init(characterRepo: CharacterStorable, cache: Cacheable) {
        self.characterRepo = characterRepo
        self.cache = cache
        rootViewController = UINavigationController()
    }
}

extension MainCoordinator: Coordinator {
    func start() {
        let mainListController = MainListViewController(charactersRepo: characterRepo,
                                                        navigationListener: self,
                                                        cache: cache)
        rootViewController.setViewControllers([mainListController], animated: false)
    }

    func checkDetails(for selectedCharacter: CharacterDTO) {
        let detailsController = DetailsViewController(charactersRepo: characterRepo,
                                                      currentCharacter: selectedCharacter,
                                                      cache: cache)

        rootViewController.present(detailsController, animated: true)
    }
}
