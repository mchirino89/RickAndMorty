//
//  CachedListing.swift
//  R&M
//
//  Created by Mauricio Chirino on 03/01/21.
//

import UIKit

final class CachedListing: NSObject {
    public let cache: Cacheable
    public var data: [CachedThumbnail]

    /// Queue that handles all avatar download operations
    let imageLoadQueue = OperationQueue()
    /// Dictionary that matches image download with corresponding cell's index path.
    var imageLoadOperations = [IndexPath: ImageLoadOperation]()

    public init(cache: Cacheable = CacheStore(), data: [CachedThumbnail]) {
        self.cache = cache
        self.data = data

        super.init()
    }
}

extension CachedListing: UICollectionViewDataSourcePrefetching {
    /// Indexes to be added into operation queue whenever the user starts scrolling
    /// - Parameters:
    ///   - collectionView: collection view attached to this event
    ///   - indexPaths: resulting array with indexes to be added
    public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if imageLoadOperations[indexPath] != nil {
                return
            }

            let imageLoadOperation = ImageLoadOperation(url: data[indexPath.row].avatar)
            imageLoadQueue.addOperation(imageLoadOperation)
            imageLoadOperations[indexPath] = imageLoadOperation
        }
    }

    /// Indexes to be removed out of operation queue whenever the user changes scrolling direction and/or suddenly stops scrolling altogether
    /// - Parameters:
    ///   - collectionView: collection view attached to this event
    ///   - indexPaths: resulting array with indexes to be dismissed
    public func collectionView(_ collectionView: UICollectionView,
                               cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let imageLoadOperation = imageLoadOperations[indexPath] else {
                return
            }

            imageLoadOperation.cancel()
            imageLoadOperations.removeValue(forKey: indexPath)
        }
    }
}
