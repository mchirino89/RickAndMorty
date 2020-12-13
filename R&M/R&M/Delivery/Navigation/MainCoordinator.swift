//
//  MainCoordinator.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

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
//        let mainListController = MainListViewController(viewModel: MainListViewModel())
//        mainNavigator = UINavigationController(rootViewController: mainListController)

        let detailsController = DetailsViewController()
        mainNavigator = UINavigationController(rootViewController: detailsController)

        rootViewController = mainNavigator
    }

    func checkDetails(for characterId: Int) {
    }
}
