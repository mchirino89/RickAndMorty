//
//  CharactersRepo.swift
//  R&M
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation
import MauriNet
import MauriUtils

typealias CharacterResult = (Result<[CharacterDTO], NetworkError>) -> Void
typealias AvatarResult = (Result<Data, NetworkError>) -> Void

protocol CharacterStorable {
    func allCharacters(onCompletion: @escaping CharacterResult)
    func filteredCharacters(by type: String, onCompletion: @escaping CharacterResult)
    func avatar(from URL: URL, onCompletion: @escaping AvatarResult)
}

struct CharacterStoredRepo: CharacterStorable {
    private let networkService: RequestableManager
    private let endpointSetup: RepoSetup

    init(networkService: RequestableManager = RequestManager()) {
        self.networkService = networkService
        // This is a force unwrap since failing here would invalidate the entire app setup. It's best to crash early
        endpointSetup = try! FileReader().decodePlist(from: "RepoSetup")
    }

    func allCharacters(onCompletion: @escaping CharacterResult) {
        let assembledRequest = EndpointBuilder(host: endpointSetup.host,
                                               path: endpointSetup.charactersEndpoint).assembleRequest()

        fetchOnAPI(using: assembledRequest, onCompletion: onCompletion)
    }

    func filteredCharacters(by species: String, onCompletion: @escaping CharacterResult) {
        let queryParameters: [String: String] = [endpointSetup.filterTypeEndpoint: species]
        let assembledRequest = EndpointBuilder(host: endpointSetup.host,
                                               path: endpointSetup.charactersEndpoint,
                                               queryParameters: queryParameters).assembleRequest()

        fetchOnAPI(using: assembledRequest, onCompletion: onCompletion)
    }

    func avatar(from URL: URL, onCompletion: @escaping AvatarResult) {
        let avatarRequest = URLRequest(url: URL)

        networkService.request(avatarRequest) { result in
            switch result {
            case .success(let retrievedData):
                onCompletion(.success(retrievedData))
            case .failure(let producedError):
                onCompletion(.failure(producedError))
            }
        }
    }

    private func fetchOnAPI(using assembledRequest: URLRequest, onCompletion: @escaping CharacterResult) {
        networkService.request(assembledRequest) { result in
            switch result {
            case .success(let retrievedData):
                do {
                    let successfulResponse: ResponseDTO = try JSONDecodable.map(input: retrievedData)
                    onCompletion(.success(successfulResponse.results))
                } catch {
                    onCompletion(.failure(.conflictOnResource))
                }
            case .failure(let producedError):
                onCompletion(.failure(producedError))
            }
        }
    }
}
