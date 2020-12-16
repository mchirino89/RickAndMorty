//
//  CacheStore.swift
//  R&M
//
//  Created by Mauricio Chirino on 16/12/20.
//

import UIKit

protocol Cacheable {
    func object(at key: String) -> UIImage?
    func store(image: UIImage, at key: String)
}

final class CacheStore: Cacheable {
    let cache = NSCache<NSString, UIImage>()

    private func generated(_ key: String) -> NSString {
        key as NSString
    }

    func object(at key: String) -> UIImage? {
        return cache.object(forKey: generated(key))
    }

    func store(image: UIImage, at key: String) {
        cache.setObject(image, forKey: generated(key))
    }
}
