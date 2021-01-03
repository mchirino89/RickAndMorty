//
//  ListViewModel.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import Foundation

struct ListViewModel {
    private weak var dataSource: DataSource<CacheSourceable>?
    private let charactersRepo: CharacterStorable
    // This reference needs to be strong since view model isn't being retained on the coordinator
    private var navigationListener: Coordinator

    init(dataSource: DataSource<CacheSourceable>?,
         charactersRepo: CharacterStorable,
         navigationListener: Coordinator) {
        self.dataSource = dataSource
        self.charactersRepo = charactersRepo
        self.navigationListener = navigationListener
    }

    func fetchCharacters() {
        charactersRepo.allCharacters { result in
            switch result {
            case .success(let retrievedCharacters):
                dataSource?.data.value = retrievedCharacters
            case .failure(let error):
                dataSource?.data.value = []
                // TODO: Add proper UI error handling
                print(error)
            }
        }
    }

    func checkDetails(for character: CacheSourceable) {
        navigationListener.checkDetails(for: character)
    }
}
