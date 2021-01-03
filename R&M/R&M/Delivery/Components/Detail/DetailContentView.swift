//
//  DetailContentView.swift
//  R&M
//
//  Created by Mauricio Chirino on 13/12/20.
//

import UIKit

final class DetailContentView: UICollectionView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: LayoutBuilder.assembleGridLayout(direction: .horizontal))
        register(cellType: CharacterCell.self)
        backgroundColor = .clear
        bounces = false
    }
}
