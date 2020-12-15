//
//  CharacterViewModel.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import Foundation

struct CharacterViewModel {
    private weak var dataSource: DataSource<CharacterDTO>?
    private let charactersRepo: CharacterStorable
    private var navigationListener: Coordinator

    init(dataSource: DataSource<CharacterDTO>?,
         charactersRepo: CharacterStorable,
         navigationListener: Coordinator) {
        self.dataSource = dataSource
        self.charactersRepo = charactersRepo
        self.navigationListener = navigationListener
    }

    func fetchCharacters() {
        charactersRepo.allCharacters { result in
            performUIUpdate {
                switch result {
                case .success(let retrievedCharacters):
                    dataSource?.data.value = retrievedCharacters
                case .failure(let error):
                    #warning("Add proper UI error handling")
                    print(error)
                }
            }
        }
    }

    func checkDetails(for character: CharacterDTO) {
        navigationListener.checkDetails(for: character)
    }
}
