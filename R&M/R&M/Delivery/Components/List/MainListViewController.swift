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
    private let viewModel: ListViewModel
    private var listListener: ListInteractable

    init(charactersRepo: CharacterStorable,
         navigationListener: Coordinator,
         listListener: ListInteractable = ListInteractor()) {
        self.listListener = listListener
        dataSource = CharacterDataSource()
        viewModel = ListViewModel(dataSource: dataSource,
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
        listenListUpdate()
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
        listListener.listView = listView
        listListener.delegate = self
    }

    func listenListUpdate() {
        viewModel.fetchCharacters()
        dataSource.render { [weak listView] in
            performUIUpdate {
                listView?.reloadData()
            }
        }
    }
}

extension MainListViewController: ListDelegate {
    func didSelected(at index: Int) {
        let selectedCharacter = dataSource.selectedCharacter(at: index)

        viewModel.checkDetails(for: selectedCharacter)
    }
}
