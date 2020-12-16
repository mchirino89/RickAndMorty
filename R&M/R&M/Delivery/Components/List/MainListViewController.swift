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
        listing.prefetchDataSource = dataSource

        return listing
    }()

    private lazy var activityLoader: UIActivityIndicatorView = LoaderBuilder.assemble()

    private let dataSource: CharacterDataSource
    private let viewModel: ListViewModel
    private var listListener: ListInteractable

    init(charactersRepo: CharacterStorable,
         navigationListener: Coordinator,
         cache: NSCache<NSString, UIImage>,
         listListener: ListInteractable = ListInteractor()) {
        self.listListener = listListener
        dataSource = CharacterDataSource(cache: cache)
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
        viewModel.fetchCharacters()
    }
}

private extension MainListViewController {
    func initialSetup() {
        title = ListDictionary.title.rawValue
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(listView)
        view.addSubview(activityLoader, constraints: [
            pinToCenter()
        ])
    }

    func wireListBehavior() {
        listListener.listView = listView
        listListener.delegate = self
    }

    func listenListUpdate() {
        let uiUpdateCompletion: () -> Void = { [weak listView, weak activityLoader] in
            listView?.reloadData()
            activityLoader?.stopAnimating()
        }

        let renderCompletion: () -> Void = {
            performUIUpdate(using: uiUpdateCompletion)
        }

        dataSource.render(completion: renderCompletion)
    }
}

extension MainListViewController: ListDelegate {
    func didSelected(at index: Int) {
        let selectedCharacter = dataSource.selectedCharacter(at: index)

        viewModel.checkDetails(for: selectedCharacter)
    }
}
