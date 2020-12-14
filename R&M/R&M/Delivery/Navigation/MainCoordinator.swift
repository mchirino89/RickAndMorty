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
    func checkDetails(for characterId: Int)
}

final class MainCoordinator {
    var mainNavigator: UINavigationController?
    var rootViewController: UIViewController?
}

extension MainCoordinator: Coordinator {
    func start() {
//        let mockCharacter: CharacterDTO = try! FileReader().decodeJSON(from: "Rick")
//        let mainListController = MainListViewController(viewModel: CharacterViewModel(character: mockCharacter))
//        mainNavigator = UINavigationController(rootViewController: mainListController)

//        let detailsController = DetailsViewController(viewModel: CharacterViewModel(character: mockCharacter))
//        mainNavigator = UINavigationController(rootViewController: detailsController)

        rootViewController = mainNavigator
    }

    func checkDetails(for characterId: Int) {
    }
}
