//
//  DetailsViewModel.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

struct DetailsViewModel {
    private weak var dataSource: DataSource<CharacterDTO>?
    private let charactersRepo: CharacterStorable
    let currentCharacter: CharacterDTO

    init(dataSource: DataSource<CharacterDTO>?,
         charactersRepo: CharacterStorable,
         currentCharacter: CharacterDTO) {
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
                #warning("Add proper UI error handling")
                print(error)
            }
        }
    }
}
