//
//  CharacterDTO.swift
//  R&M
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation

struct CharacterLocationDTO: Codable {
    let name: String
}

struct CharacterDTO: Codable {
    let identifier: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let avatar: URL
    let endpoint: URL
    private let originLocation: CharacterLocationDTO
    private let currentLocation: CharacterLocationDTO

    var origin: String {
        originLocation.name
    }

    var current: String {
        currentLocation.name
    }

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case status
        case species
        case gender
        case avatar = "image"
        case endpoint = "url"
        case originLocation = "origin"
        case currentLocation = "location"
    }
}
