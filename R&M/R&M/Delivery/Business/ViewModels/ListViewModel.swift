//
//  ListViewModel.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import Foundation
import MauriUtils

struct ListViewModel {
    private weak var dataSource: DataSource<CardSourceable>?
    private let charactersRepo: CharacterStorable
    // This reference needs to be strong since view model isn't being retained on the coordinator
    private var navigationListener: Coordinator

    init(dataSource: DataSource<CardSourceable>?,
         charactersRepo: CharacterStorable,
         navigationListener: Coordinator) {
        self.dataSource = dataSource
        self.charactersRepo = charactersRepo
        self.navigationListener = navigationListener
    }

    private func handleResponse(basedOn result: Result<[CharacterDTO], Error>) {
        switch result {
        case .success(let retrievedCharacters):
            dataSource?.data.value = retrievedCharacters
        case .failure(let error):
            dataSource?.data.value = []
            // TODO: Add proper UI error handling
            print(error)
        }
    }

    func fetchCharacters() {
        charactersRepo.allCharacters { result in
            handleResponse(basedOn: result)
        }
    }

    func requestRandomCharacters() {

        charactersRepo.randomCharacters { result in
            handleResponse(basedOn: result)
        }
    }

    func checkDetails(for character: CardSourceable) {
        navigationListener.checkDetails(for: character)
    }
}
