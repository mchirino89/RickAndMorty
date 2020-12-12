//
//  ListContent.swift
//  R&M
//
//  Created by Mauricio Chirino on 10/12/20.
//

import UIKit

fileprivate struct LayoutBuilder {
    /// Returns a 2 x 2 grid with dynamic size cells and _standard_ padding between its elements [Source](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
    /// - Returns: `UICollectionViewCompositionalLayout` assembled grid layout
    static func assembleGridLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = UIConstants.standardPadding
        group.interItemSpacing = .flexible(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

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
