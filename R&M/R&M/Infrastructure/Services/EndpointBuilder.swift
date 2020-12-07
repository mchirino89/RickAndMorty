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

    func assembleRequest() -> URLRequest {
        switch APIEndpoint(host: host).buildRequest(for: path) {
        case .success(let assembledRequest):
            return assembledRequest
        case .failure:
            return URLRequest(url: URL.init(validURL: ""))
        }
    }
}
