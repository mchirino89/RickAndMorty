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

struct MainCoordinator {
    var mainNavigator: UINavigationController?
    var rootViewController: UIViewController?
}

extension MainCoordinator: Coordinator {
    func start() {
        
    }

    func checkDetails(for characterId: Int) {
    }
}
