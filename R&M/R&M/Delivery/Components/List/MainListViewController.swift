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
    private var listListener: ListInteractable

    init(charactersRepo: CharacterStorable,
         navigationListener: Coordinator,
         listListener: ListInteractable = ListInteractor()) {
        self.listListener = listListener
        dataSource = CharacterDataSource()
        viewModel = CharacterViewModel(dataSource: dataSource,
                                       charactersRepo: charactersRepo,
                                       navigationListener: navigationListener)
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
            performUIUpdate {
                listView?.reloadData()
            }
        }

        listListener.listView = listView
        listListener.delegate = self
        viewModel.fetchCharacters()
    }
}

extension MainListViewController: ListDelegate {
    func didSelected(at index: Int) {
        let selectedCharacter = dataSource.selectedCharacter(at: index)

        viewModel.checkDetails(for: selectedCharacter)
    }
}
