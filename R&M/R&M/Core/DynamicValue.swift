//
//  DynamicValue.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation

typealias CompletionHandler = (() -> Void)

final class DynamicValue<T> {
    var value: T {
        didSet {
            notify()
        }
    }

    private var observers = [String: CompletionHandler]()

    init(_ value: T) {
        self.value = value
    }

    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        addObserver(observer, completionHandler: completionHandler)
        notify()
    }

    private func notify() {
        observers.forEach {
            $0.value()
        }
    }

    deinit {
        observers.removeAll()
    }
}

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
