//
//  CharacterDataSource.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import MauriKit
import UIKit

final class CharacterDataSource: DataSource<ImageSourceable> {
    /// Queue that handles all avatar download operations
    let imageLoadQueue = OperationQueue()
    /// Dictionary that matches image download with corresponding cell's index path.
    var imageLoadOperations = [IndexPath: ImageLoadOperation]()
    let cache: Cacheable

    init(cache: Cacheable) {
        self.cache = cache
        super.init()
    }

    func render(completion: @escaping (() -> Void)) {
        data.update { _ in
            completion()
        }
    }

    /// Returns the image associated to an URL (should it find it) or a placeholder one in case it doesn't exist
    /// - Parameter url: URL to search for image on cache storage
    /// - Returns: safe `UIImage` object
    func cachedImage(for url: URL) -> UIImage {
        return cache.object(at: url.absoluteString) ?? AssetCatalog.placeholder.image
    }

    /// Properly cancelling all pending operations before being deallocated in order to reduce network footprint and avoid retain cycles.
    deinit {
        imageLoadOperations.forEach {
            $1.cancel()
        }
        imageLoadOperations.removeAll()

        if imageLoadOperations.isEmpty {
            print("properly clean operation queue on dealloc")
        }
    }
}

extension CharacterDataSource {
    func selectedCharacter(at index: Int) -> ImageSourceable {
        return data.value[index]
    }
}

private extension CharacterDataSource {
    /// Adds a request for avatar's image to the download queue, checking first if it exists on cache in order to avoid doing so in case it does.
    /// If it doesn't, checks on `imageLoadOperations` key for the provided index to get it. In case said index hasn't been added to the download queue, it proceeds to do so and react when it finishes -updating also cache state with it- and syncs the cell matching said indexPath
    /// - Parameters:
    ///   - currentURL: avatar's URL origin
    ///   - cell: cell on screen corresponding to avatar's image
    ///   - index: index path corresponding to cell requesting the image
    func queueThumbnail(from currentURL: URL, for cell: ListableCell, at index: IndexPath) {
        guard let cachedImage = cache.object(at: currentURL.absoluteString) else {
            if let imageLoadOperation = imageLoadOperations[index],
                let image = imageLoadOperation.image {
                setThumbnail(cell, image, currentURL.absoluteString, at: index.row)
                cache.store(image: image, at: currentURL.absoluteString)
            } else {
                let imageLoadOperation = ImageLoadOperation(url: currentURL)
                imageLoadOperation.completionHandler = { [unowned self] image in
                    self.setThumbnail(cell, image, currentURL.absoluteString, at: index.row)
                    self.cache.store(image: image, at: currentURL.absoluteString)
                    self.imageLoadOperations.removeValue(forKey: index)
                }
                imageLoadQueue.addOperation(imageLoadOperation)
                imageLoadOperations[index] = imageLoadOperation
            }
            return
        }

        setThumbnail(cell, cachedImage, currentURL.absoluteString, at: index.row)
    }

    /// Handles cell update with matching avatar for it, should it correspond to do so
    /// - Parameters:
    ///   - cell: cell to match
    ///   - image: image to add on cell
    ///   - url: URL corresponding to said image
    ///   - index: index corresponding to said cell
    func setThumbnail(_ cell: ListableCell, _ image: UIImage, _ url: String, at index: Int) {
        performUIUpdate { [weak self] in
            /// This prevents classic mismatch in images due to recycling on collection view's cells
            if self?.data.value[index].avatar.absoluteString == url {
                cell.setThumbnail(image: image)
            }
        }
    }
}

extension CharacterDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.value.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentCharacter = data.value[indexPath.row]
        let characterCell: CharacterCell = collectionView.dequeue(at: indexPath)
        characterCell.setInformation(currentCharacter)
        queueThumbnail(from: currentCharacter.avatar, for: characterCell, at: indexPath)

        return characterCell
    }
}

extension CharacterDataSource: UICollectionViewDataSourcePrefetching {
    /// Indexes to be added into operation queue whenever the user starts scrolling
    /// - Parameters:
    ///   - collectionView: collection view attached to this event
    ///   - indexPaths: resulting array with indexes to be added
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if imageLoadOperations[indexPath] != nil {
                return
            }

            let imageLoadOperation = ImageLoadOperation(url: data.value[indexPath.row].avatar)
            imageLoadQueue.addOperation(imageLoadOperation)
            imageLoadOperations[indexPath] = imageLoadOperation
        }
    }

    /// Indexes to be removed out of operation queue whenever the user changes scrolling direction and/or suddenly stops scrolling altogether
    /// - Parameters:
    ///   - collectionView: collection view attached to this event
    ///   - indexPaths: resulting array with indexes to be dismissed
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let imageLoadOperation = imageLoadOperations[indexPath] else {
                return
            }
            imageLoadOperation.cancel()
            imageLoadOperations.removeValue(forKey: indexPath)
        }
    }
}
