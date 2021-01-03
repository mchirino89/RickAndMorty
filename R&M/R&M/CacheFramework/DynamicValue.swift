//
//  DynamicValue.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation

public final class Dynamic<T> {
    public typealias Listener = (T) -> Void

    public var listener: Listener?

    public var value: T {
        didSet {
            listener?(value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public func update(_ listener: Listener?) {
        self.listener = listener

        listener?(value)
    }
}
