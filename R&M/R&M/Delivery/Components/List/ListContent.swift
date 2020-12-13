//
//  ListContent.swift
//  R&M
//
//  Created by Mauricio Chirino on 10/12/20.
//

import UIKit

final class ListContent: UICollectionView {
    static let cellIdentifier: String = "characterCell"

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: LayoutBuilder.assembleGridLayout())
        register(ListCharacterCell.self, forCellWithReuseIdentifier: ListContent.cellIdentifier)
        backgroundColor = .systemBackground
    }
}
