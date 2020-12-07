//
//  RepoSetup.swift
//  R&M
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation

struct RepoSetup: Decodable {
    let host: String
    let charactersEndpoint: String
    let filterTypeEndpoint: String
}
