//
//  MainListViewController.swift
//  R&M
//
//  Created by Mauricio Chirino on 06/12/20.
//

import UIKit

final class MainListViewController: UIViewController {
    private let viewModel: MainListViewModel
    private lazy var listView = buildList()

    init(viewModel: MainListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

private extension MainListViewController {
    func buildList() -> UICollectionView {
        let list = UICollectionView()
        return UICollectionView()
    }
}
