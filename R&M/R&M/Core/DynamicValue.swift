//
//  DynamicValue.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation

struct Dynamic<T> {
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

    mutating func bind(_ listener: Listener?) {
        self.listener = listener
    }

    mutating func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
