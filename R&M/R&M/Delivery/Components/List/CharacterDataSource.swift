//
//  CharacterDataSource.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import UIKit

final class ThumbnailDataSource: DataSource<(Data, Int)> {
    func render(completion: @escaping ((Data, Int) -> Void)) {
        data.update { result in
            result.forEach { data, index in
                completion(data, index)
            }
        }
    }
}

final class CharacterDataSource: DataSource<CharacterDTO> {
    func render(completion: @escaping (() -> Void)) {
        data.update { _ in
            completion()
        }
    }

    func selectedCharacter(at index: Int) -> CharacterDTO {
        data.value[index]
    }
}

extension CharacterDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.value.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListContentView.cellIdentifier,
                                                               for: indexPath) as! CharacterCell
        characterCell.setInformation(data.value[indexPath.row])

        return characterCell
    }
}
