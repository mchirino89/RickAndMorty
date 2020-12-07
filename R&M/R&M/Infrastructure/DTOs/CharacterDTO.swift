//
//  CharacterDTO.swift
//  R&M
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation

struct CharacterLocation: Decodable {
    let name: String
}

struct Character: Decodable {
    let identifier: String
    let name: String
    let status: String
    let species: String
    let gender: String
    let avatar: String
    let endpoint: String
    let origin: CharacterLocation
    let currentLocation: CharacterLocation

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case status
        case species
        case gender
        case avatar = "image"
        case endpoint = "url"
        case origin
        case currentLocation = "location"
    }
}
