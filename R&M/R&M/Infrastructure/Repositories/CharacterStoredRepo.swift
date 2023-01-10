//
//  CharactersRepo.swift
//  R&M
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation
import MauriNet
import MauriUtils

typealias CharacterResult = (Result<[CharacterDTO], Error>) -> Void

protocol CharacterStorable {
    func randomCharacters(onCompletion: @escaping CharacterResult)
    func allCharacters(onCompletion: @escaping CharacterResult)
    func filteredCharacters(by type: String, onCompletion: @escaping CharacterResult)
}

struct CharacterStoredRepo {
    private let networkService: RequestableManager
    private let endpointSetup: RepoSetup
    private let endpointBuilder: EndpointBuilder
    private var randomGenerator: Randomable

    init(networkService: RequestableManager = RequestManager(),
         randomGenerator: Randomable = RandomGenerator(totalPages: 41)) {
        self.networkService = networkService
        self.randomGenerator = randomGenerator
        // This force unwrap is acceptable since failing here would invalidate the entire app setup.
        // It's best to crash early
        endpointSetup = try! FileReader().decodePlist(from: "RepoSetup")
        endpointBuilder = EndpointBuilder(endpointSetup: APIEndpoint(host: endpointSetup.host))
    }

    private func fetchOnAPI(using assembledRequest: URLRequest, onCompletion: @escaping CharacterResult) {
        networkService.request(assembledRequest) { result in
            switch result {
            case .success(let retrievedData):
                do {
                    let successfulResponse: ResponseDTO = try JSONDecodable.map(input: retrievedData)
                    onCompletion(.success(successfulResponse.results))
                } catch {
                    onCompletion(.failure(NetworkError.conflictOnResource))
                }
            case .failure(let producedError):
                onCompletion(.failure(producedError))
            }
        }
    }
}

extension CharacterStoredRepo: CharacterStorable {
    func allCharacters(onCompletion: @escaping CharacterResult) {
        let assembledRequest = endpointBuilder.assembleRequest(path: endpointSetup.charactersEndpoint)

        fetchOnAPI(using: assembledRequest, onCompletion: onCompletion)
    }

    func filteredCharacters(by species: String, onCompletion: @escaping CharacterResult) {
        let queryParameters: [String: String] = [endpointSetup.filterTypeEndpoint: species]
        let assembledRequest = endpointBuilder.assembleRequest(path: endpointSetup.charactersEndpoint,
                                                               queryParameters: queryParameters)

        fetchOnAPI(using: assembledRequest, onCompletion: onCompletion)
    }

    func randomCharacters(onCompletion: @escaping CharacterResult) {
        let queryParameters: [String: String] = [endpointSetup.pagesParameter: randomGenerator.produceRandomPage()]
        let assembledRequest = endpointBuilder.assembleRequest(path: endpointSetup.charactersEndpoint,
                                                               queryParameters: queryParameters)

        fetchOnAPI(using: assembledRequest, onCompletion: onCompletion)
    }
}
