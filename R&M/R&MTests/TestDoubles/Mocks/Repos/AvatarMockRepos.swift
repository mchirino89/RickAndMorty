//
//  AvatarMockRepos.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 16/12/20.
//

import Foundation
import MauriUtils
@testable import R_M

struct AvatarSuccessMockRepo: ImagesStockable {
    func avatar(from URL: URL, onCompletion: @escaping AvatarResult) {
        let dummyData = "avatarImageDummyBlog".data(using: .utf8)!

        onCompletion(.success(dummyData))
    }
}

struct AvatarFailureMockRepo: ImagesStockable {
    func avatar(from URL: URL, onCompletion: @escaping AvatarResult) {
        onCompletion(.failure(.notFound))
    }
}
