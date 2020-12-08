//
//  EndpointBuilder.swift
//  R&M
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation
import MauriNet

struct EndpointBuilder {
    let host: String
    let path: String
    let queryParameters: [String: String]

    init(host: String,
         path: String,
         queryParameters: [String: String] = [:]) {
        self.host = host
        self.path = path
        self.queryParameters = queryParameters
    }
    
    func assembleRequest() -> URLRequest {
        switch APIEndpoint(host: host).buildRequest(for: path, with: queryParameters) {
        case .success(let assembledRequest):
            return assembledRequest
        case .failure:
            return URLRequest(url: URL.init(validURL: ""))
        }
    }
}
