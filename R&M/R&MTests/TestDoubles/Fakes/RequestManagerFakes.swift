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

final class FakeRequestManagerSuccessResponse: RequestableManager {
    func request(_ request: URLRequest, completion: @escaping NetworkResult) {
        if request.url?.absoluteString.contains("species") == true {
            let characters: ResponseDTO = try! FileReader().decodeJSON(from: "Species")
            let parsedJSON = try! JSONEncoder().encode(characters)

            completion(.success(parsedJSON))
        } else if request.url?.absoluteString.contains("character") == true {
            let characters: ResponseDTO = try! FileReader().decodeJSON(in: Bundle(for: Self.self),
                                                                       from: "MultipleCharacters")
            let parsedJSON = try! JSONEncoder().encode(characters)

            completion(.success(parsedJSON))
        }
    }
}
