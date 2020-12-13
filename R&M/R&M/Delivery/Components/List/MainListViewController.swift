//
//  MainListViewController.swift
//  R&M
//
//  Created by Mauricio Chirino on 06/12/20.
//

import MauriUtils
import UIKit

final class MainListViewController: UIViewController {
    private let viewModel: MainListViewModel
    private lazy var listView: ListContentView = {
        let listing = ListContentView(frame: view.frame)
        listing.dataSource = self

        return listing
    }()

    private lazy var characters: ResponseDTO = {
        let mock: ResponseDTO = try! FileReader().decodeJSON(from: "MultipleCharacters")

        return mock
    }()

    init(viewModel: MainListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

private extension MainListViewController {
    func initialSetup() {
        title = "Rick and Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(listView)
    }
}

extension MainListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        characters.results.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: ListContentView.cellIdentifier,
                                                               for: indexPath) as! CharacterCell

        characterCell.setInformation(characters.results[indexPath.row])
        return characterCell
    }
}
