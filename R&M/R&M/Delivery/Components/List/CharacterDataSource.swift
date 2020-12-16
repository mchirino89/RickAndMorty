//
//  CharacterDataSource.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import UIKit

final class CharacterDataSource: DataSource<CharacterDTO> {
    let imageLoadQueue = OperationQueue()
    var imageLoadOperations = [IndexPath: ImageLoadOperation]()
    let cache: NSCache<NSString, UIImage>

    init(cache: NSCache<NSString, UIImage>) {
        self.cache = cache
        super.init()
    }

    func render(completion: @escaping (() -> Void)) {
        data.update { _ in
            completion()
        }
    }

    func selectedCharacter(at index: Int) -> CharacterDTO {
        data.value[index]
    }

    func cacheAvatar(for url: URL) -> UIImage {
        let cacheKey = url.absoluteString as NSString

        return cache.object(forKey: cacheKey) ?? AssetCatalog.placeholder.image
    }

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

private extension CharacterDataSource {
    func queueThumbnail(from currentURL: URL, for cell: CharacterCell, at index: IndexPath) {
        let cacheKey = currentURL.absoluteString as NSString

        guard let cachedImage = cache.object(forKey: cacheKey) else {
            if let imageLoadOperation = imageLoadOperations[index],
                let image = imageLoadOperation.image {
                setThumbnail(cell, image, currentURL.absoluteString, at: index.row)
                cache.setObject(image, forKey: cacheKey)
            } else {
                let imageLoadOperation = ImageLoadOperation(url: currentURL)
                imageLoadOperation.completionHandler = { [unowned self] image in
                    self.setThumbnail(cell, image, currentURL.absoluteString, at: index.row)
                    self.cache.setObject(image, forKey: cacheKey)
                    self.imageLoadOperations.removeValue(forKey: index)
                }
                imageLoadQueue.addOperation(imageLoadOperation)
                imageLoadOperations[index] = imageLoadOperation
            }
            return
        }

        setThumbnail(cell, cachedImage, currentURL.absoluteString, at: index.row)
    }

    func setThumbnail(_ cell: CharacterCell, _ image: UIImage, _ url: String, at index: Int) {
        performUIUpdate { [weak self] in
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
        let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListContentView.cellIdentifier,
                                                               for: indexPath) as! CharacterCell
        characterCell.setInformation(currentCharacter)
        queueThumbnail(from: currentCharacter.avatar, for: characterCell, at: indexPath)

        return characterCell
    }
}

extension CharacterDataSource: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            if let _ = imageLoadOperations[indexPath] {
                return
            }

            let imageLoadOperation = ImageLoadOperation(url: data.value[indexPath.row].avatar)
            imageLoadQueue.addOperation(imageLoadOperation)
            imageLoadOperations[indexPath] = imageLoadOperation
        }
    }

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

