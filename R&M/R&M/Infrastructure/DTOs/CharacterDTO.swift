//
//  CharacterDTO.swift
//  R&M
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation

protocol ImageSourceable {
    var avatar: URL { get }
}

struct CharacterLocationDTO: Codable {
    let name: String
}

struct CharacterDTO: Codable, ImageSourceable {
    let identifier: Int
    let name: String
    let status: String
    let species: String
    let avatar: URL
    let endpoint: URL
    private let originLocation: CharacterLocationDTO

    var origin: String {
        originLocation.name
    }

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case status
        case species
        case avatar = "image"
        case endpoint = "url"
        case originLocation = "origin"
    }
}
