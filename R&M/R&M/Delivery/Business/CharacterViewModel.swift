//
//  CharacterViewModel.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import Foundation

struct CharacterViewModel /*: GenericSourcable*/ {
//    typealias T = CharacterDTO
//    weak var data: Dynamic<[CharacterDTO]>?

    weak var dataSource: DataSource<CharacterDTO>?
    private let charactersRepo: CharacterStorable

    init(dataSource: DataSource<CharacterDTO>?,
         charactersRepo: CharacterStorable) {
        self.dataSource = dataSource
        self.charactersRepo = charactersRepo
    }

    func fetchCharacters() {
        charactersRepo.allCharacters { result in
            performUIUpdate {
                switch result {
                case .success(let retrievedCharacters):
                    dataSource?.data.value = retrievedCharacters
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
