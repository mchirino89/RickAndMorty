//
//  CacheStore.swift
//  R&M
//
//  Created by Mauricio Chirino on 16/12/20.
//

import UIKit

public protocol Cacheable {
    func object(at key: String) -> UIImage?
    func store(image: UIImage, at key: String)
    func reset()
}

public final class CacheStore {
    let cache: NSCache<NSString, UIImage>

    private func generated(_ key: String) -> NSString {
        key as NSString
    }

    public init() {
        cache = NSCache<NSString, UIImage>()
    }
}

extension CacheStore: Cacheable {
    public func object(at key: String) -> UIImage? {
        return cache.object(forKey: generated(key))
    }

    public func store(image: UIImage, at key: String) {
        cache.setObject(image, forKey: generated(key))
    }

    public func reset() {
        cache.removeAllObjects()
    }
}
