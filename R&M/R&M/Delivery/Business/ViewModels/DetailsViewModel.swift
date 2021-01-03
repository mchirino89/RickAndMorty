//
//  DetailsViewModel.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

struct DetailsViewModel {
    private weak var dataSource: DataSource<CacheSourceable>?
    private let charactersRepo: CharacterStorable
    let currentCharacter: CacheSourceable

    init(dataSource: DataSource<CacheSourceable>?,
         charactersRepo: CharacterStorable,
         currentCharacter: CacheSourceable) {
        self.dataSource = dataSource
        self.charactersRepo = charactersRepo
        self.currentCharacter = currentCharacter
    }

    func fetchRelatedSpecies() {
        charactersRepo.filteredCharacters(by: currentCharacter.species) { result in
            switch result {
            case .success(let retrievedCharacters):
                dataSource?.data.value = retrievedCharacters
            case .failure(let error):
                // TODO: Add proper UI error handling
                print(error)
            }
        }
    }
}
