//
//  FailureRequestManagerStubbedFailures.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 08/12/20.
//

import Foundation
import MauriNet
@testable import R_M

// Another approach would have been build a fake double that handles each and every possible supported error so far
struct ParserRequestManagerStubbedFailure: RequestableManager {
    func request(_ request: URLRequest, completion: @escaping NetworkResult) {
        completion(.success(Data()))
    }
}

struct NetworkConnectionRequestManagerStubbedFailure: RequestableManager {
    func request(_ request: URLRequest, completion: @escaping NetworkResult) {
        completion(.failure(.serverDown))
    }
}
