//
//  GenericDataSource.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation

protocol GenericSourcable {
    associatedtype T

    var data: Dynamic<[T]> { get set }

    func render(completion: @escaping (([T]) -> Void))
}

extension GenericSourcable {
    mutating func render(completion: @escaping (([T]) -> Void)) {
        data.bindAndFire {
            completion($0)
        }
    }
}

class GenericDataSource<T>: NSObject {
    var data: Dynamic<[T]> = Dynamic([])
}
