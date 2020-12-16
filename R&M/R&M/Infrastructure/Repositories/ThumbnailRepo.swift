//
//  ThumbnailRepo.swift
//  R&M
//
//  Created by Mauricio Chirino on 15/12/20.
//

import UIKit

typealias ImageLoadOperationCompletionHandlerType = ((UIImage) -> ())?

final class ImageLoadOperation: Operation {
    var completionHandler: ImageLoadOperationCompletionHandlerType?
    var image: UIImage?
    let url: URL
    let remoteRepo: CharacterStorable

    init(url: URL, remoteRepo: CharacterStorable = CharacterStoredRepo()) {
        self.url = url
        self.remoteRepo = remoteRepo
    }

    override func main() {
        if isCancelled {
            return
        }

        queuePriority = .high
        remoteRepo.avatar(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                let decodedImage = UIImage(data: imageData) ?? AssetCatalog.placeholder.image
                self?.image = decodedImage
                self?.completionHandler??(decodedImage)
            case .failure(let error):
                #warning("Add proper UI error handling")
                print(error.localizedDescription)
            }
        }
    }
}
