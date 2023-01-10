//
//  ResponseDTO.swift
//  R&M
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation

struct PageInfoDTO: Codable {
    let itemTotal: Int
    let totalPages: Int
    let nextPage: URL
    let previousPage: URL?

    private enum CodingKeys: String, CodingKey {
        case itemTotal = "count"
        case totalPages = "pages"
        case nextPage = "next"
        case previousPage = "prev"
    }
}

struct ResponseDTO: Codable {
    let info: PageInfoDTO
    let results: [CharacterDTO]
}
