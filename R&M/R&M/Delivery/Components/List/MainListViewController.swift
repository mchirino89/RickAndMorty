//
//  MainListViewController.swift
//  R&M
//
//  Created by Mauricio Chirino on 06/12/20.
//

import MauriUtils
import UIKit

final class MainListViewController: UIViewController {
    private lazy var listView: ListContentView = {
        let listing = ListContentView(frame: view.frame)
        listing.dataSource = dataSource

        return listing
    }()

    private let dataSource: CharacterDataSource
    private let viewModel: CharacterViewModel

    init(charactersRepo: CharacterStorable) {
        dataSource = CharacterDataSource()
        viewModel = CharacterViewModel(dataSource: dataSource, charactersRepo: charactersRepo)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        wireListBehavior()
    }
}

private extension MainListViewController {
    func initialSetup() {
        title = ListDictionary.title.rawValue
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(listView)
    }

    func wireListBehavior() {
        dataSource.render { [weak listView] retrievedCharacters in
            listView?.reloadData()
        }

        viewModel.fetchCharacters()
    }
}
