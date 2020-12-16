//
//  DynamicValue.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation

final class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func update(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
