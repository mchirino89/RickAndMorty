//
//  DetailContentView.swift
//  R&M
//
//  Created by Mauricio Chirino on 13/12/20.
//

import UIKit

final class DetailContentView: UICollectionView {
    static let cellIdentifier: String = "characterCell"

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: LayoutBuilder.assembleGridLayout(for: .horizontal))
        register(CharacterCell.self, forCellWithReuseIdentifier: DetailContentView.cellIdentifier)
        backgroundColor = .clear
        bounces = false
    }
}
