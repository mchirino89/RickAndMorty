//
//  ListInteractor.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import UIKit

final class ListInteractor: NSObject, ListInteractable {
    var listView: UIView?
    weak var delegate: ListDelegate? {
        didSet {
            listWrapper?.delegate = self
        }
    }
}

extension ListInteractor: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelected(at: indexPath.row)
    }
}
