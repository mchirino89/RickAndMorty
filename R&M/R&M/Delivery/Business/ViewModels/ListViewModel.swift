//
//  ListViewModel.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import Foundation

struct ListViewModel {
    private weak var dataSource: DataSource<CharacterDTO>?
    private weak var imageSource: DataSource<(Data, Int)>?
    private let charactersRepo: CharacterStorable
    // This reference needs to be strong since view model isn't being retained on the coordinator
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
            switch result {
            case .success(let retrievedCharacters):
                dataSource?.data.value = retrievedCharacters
            case .failure(let error):
                dataSource?.data.value = []
                #warning("Add proper UI error handling")
                print(error)
            }
        }
    }

    // TODO: remove redundant method
    func fetchAvatars() {
        dataSource?.data.value.enumerated().forEach { index, element in
            charactersRepo.avatar(from: element.avatar) { result in
                switch result {
                case .success(let avatarData):
                    imageSource?.data.value = [(avatarData, index)]
                case .failure(let error):
                    imageSource?.data.value = [(Data(), index)]
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
