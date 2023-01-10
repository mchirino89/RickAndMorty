//
//  ListInteractable.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import UIKit

protocol ListDelegate: AnyObject {
    func didSelected(at index: Int)
}

/// This wrapper prevents UI layer coupling. Meaning, for the outside layers the inner implementations remain hidden. This could very well be a table view, a collection view or a List (SwiftUI) and it'd be transparent
protocol ListInteractable {
    var listView: UIView? { get set }
    var delegate: ListDelegate? { get set }
}

extension ListInteractable {
    var listWrapper: UICollectionView? {
        listView as? UICollectionView
    }
}
