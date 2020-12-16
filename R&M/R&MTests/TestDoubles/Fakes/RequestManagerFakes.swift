//
//  RequestManagerMocks.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation
import MauriNet
import MauriUtils
@testable import R_M

// Another approach would have been build a couple of separated mocks for each success case.
final class FakeRequestManagerSuccessResponse: RequestableManager {
    func request(_ request: URLRequest, completion: @escaping NetworkResult) {
        let testBundle = Bundle(for: Self.self)
        let fileReader = FileReader()

        if request.url?.absoluteString.contains("species") == true {
            let characters: ResponseDTO = try! fileReader.decodeJSON(in: testBundle, from: "Species")
            let parsedJSON = try! JSONEncoder().encode(characters)

            completion(.success(parsedJSON))
        } else if request.url?.absoluteString.contains("character") == true {
            let characters: ResponseDTO = try! fileReader.decodeJSON(in: testBundle, from: "MultipleCharacters")
            let parsedJSON = try! JSONEncoder().encode(characters)

            completion(.success(parsedJSON))
        } 
    }
}
