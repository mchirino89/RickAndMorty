//
//  LayoutBuilder.swift
//  R&M
//
//  Created by Mauricio Chirino on 13/12/20.
//

import UIKit

enum ScrollingDirection {
    case horizontal
    case vertical

    var groupSize: NSCollectionLayoutSize {
        switch self {
        case .vertical:
            return NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .fractionalHeight(0.2))
        case .horizontal:
            return NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                          heightDimension: .fractionalHeight(0.2))
        }
    }

    var orthogonalBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
        self == .vertical ? .none : .continuous
    }

    func buildGroup(for item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        switch self {
        case .vertical:
            return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        case .horizontal:
            return NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
        }
    }
}

struct LayoutBuilder {
    /// Returns a 2 x 2 grid layout with dynamic size cells and _standard_ padding between its elements as well as adaptive scrolling behavior [Source](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)
    /// - Returns: `UICollectionViewCompositionalLayout` assembled grid layout
    /// - Parameter direction: scroll direction. Default `.vertical` type
    static func assembleGridLayout(for direction: ScrollingDirection = .vertical) -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = direction.buildGroup(for: item)
        let spacing = UIConstants.standardPadding
        group.interItemSpacing = .flexible(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        section.orthogonalScrollingBehavior = direction.orthogonalBehavior

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
