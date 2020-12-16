//
//  CharacterRepoMockSuccess.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation
import MauriUtils
@testable import R_M

final class CharacterRepoMockSuccess: CharacterStorable {
    private func decodeCharacters(from file: String) -> [CharacterDTO] {
        let testBundle = Bundle(for: Self.self)
        let response: ResponseDTO = try! FileReader().decodeJSON(in: testBundle, from: file)

        return response.results
    }

    func allCharacters(onCompletion: @escaping CharacterResult) {
        let characters = decodeCharacters(from: "MultipleCharacters")

        onCompletion(.success(characters))
    }

    func filteredCharacters(by type: String, onCompletion: @escaping CharacterResult) {
        let characters = decodeCharacters(from: "Species")

        onCompletion(.success(characters))
    }
}
