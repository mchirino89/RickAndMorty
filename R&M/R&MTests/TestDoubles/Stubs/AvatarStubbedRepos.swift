//
//  AvatarMockRepos.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 16/12/20.
//

import Foundation
import MauriUtils
@testable import R_M

struct AvatarRepoStubbedSuccess: ImagesStockable {
    func avatar(from URL: URL, onCompletion: @escaping AvatarResult) {
        let dummyData = "avatarImageDummyBlog".data(using: .utf8)!

        onCompletion(.success(dummyData))
    }
}

struct AvatarRepoStubbedFailure: ImagesStockable {
    func avatar(from URL: URL, onCompletion: @escaping AvatarResult) {
        onCompletion(.failure(.notFound))
    }
}
