//
//  CharacterDTO.swift
//  R&M
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation

public protocol CacheSourceable {
    var avatar: URL { get }
    var title: String { get }
    var subtitle: String { get }
    // TODO: these attributes below shouldn't be part of generic data
    var species: String { get }
    var origin: String { get }
}

struct CharacterLocationDTO: Codable {
    let name: String
}

struct CharacterDTO: Codable, CacheSourceable {
    let identifier: Int
    let title: String
    let subtitle: String
    let species: String
    let avatar: URL
    let endpoint: URL
    private let originLocation: CharacterLocationDTO

    var origin: String {
        originLocation.name
    }

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title = "name"
        case subtitle = "status"
        case species
        case avatar = "image"
        case endpoint = "url"
        case originLocation = "origin"
    }
}
