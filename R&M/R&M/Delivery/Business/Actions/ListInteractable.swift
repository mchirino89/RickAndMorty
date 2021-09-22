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

protocol ListInteractable {
    var listView: UIView? { get set }
    var delegate: ListDelegate? { get set }
}

extension ListInteractable {
    var listWrapper: UICollectionView? {
        listView as? UICollectionView
    }
}
