//
//  ListViewModel.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import Foundation

typealias CharacterThumbnailResult = (Result<(Data, Int), Error>) -> Void

struct ListViewModel {
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
            switch result {
            case .success(let retrievedCharacters):
                dataSource?.data.value = retrievedCharacters
            case .failure(let error):
                #warning("Add proper UI error handling")
                print(error)
            }
        }
    }

    func fetchAvatars(onCompletion: @escaping CharacterThumbnailResult) {
        dataSource?.data.value.enumerated().forEach { index, element in
            charactersRepo.avatar(from: element.avatar) { result in
                switch result {
                case .success(let avatarData):
                    onCompletion(.success((avatarData, index)))
                case .failure(let error):
                    onCompletion(.failure(error))
                }
            }
        }
    }

    func checkDetails(for character: CharacterDTO) {
        navigationListener.checkDetails(for: character)
    }
}