//
//  CharacterDataSource.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import UIKit

final class CharacterDataSource: DataSource<CharacterDTO> {
    func render(completion: @escaping (([CharacterDTO]) -> Void)) {
        data.update {
            completion($0)
        }
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