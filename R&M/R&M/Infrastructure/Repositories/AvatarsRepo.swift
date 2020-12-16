//
//  AvatarsRepo.swift
//  R&M
//
//  Created by Mauricio Chirino on 16/12/20.
//

import Foundation
import MauriNet

typealias AvatarResult = (Result<Data, NetworkError>) -> Void

protocol ImagesStockable {
    func avatar(from URL: URL, onCompletion: @escaping AvatarResult)
}

struct AvatarsRepo: ImagesStockable {
    private let networkService: RequestableManager

    init(networkService: RequestableManager = RequestManager()) {
        self.networkService = networkService
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
}
