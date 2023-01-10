//
//  MainListViewController.swift
//  R&M
//
//  Created by Mauricio Chirino on 06/12/20.
//

import MauriKit
import MauriUtils
import UIKit

final class MainListViewController: UIViewController {
    private lazy var listView: UICollectionView = {
        let listing = UICollectionView(frame: view.frame, collectionViewLayout: LayoutFactory.assembleGridLayout())
        listing.register(cellType: CharacterCell.self)
        listing.backgroundColor = .clear
        listing.dataSource = dataSource
        listing.prefetchDataSource = dataSource
        listing.refreshControl = refresher

        return listing
    }()

    private lazy var activityLoader: UIActivityIndicatorView = LoaderFactory.assemble()
    private lazy var refresher: UIRefreshControl = {
        let refresher = RefreshFactory.assemble(text: ListDictionary.refreshHint.rawValue)
        refresher.addTarget(self, action: #selector(refreshList), for: .valueChanged)

        return refresher
    }()

    private let dataSource: ItemDataSource
    private let viewModel: ListViewModel
    private var listListener: ListInteractable

    init(charactersRepo: CharacterStorable,
         navigationListener: Coordinator,
         cache: Cacheable,
         listListener: ListInteractable = ListInteractor()) {
        self.listListener = listListener
        dataSource = ItemDataSource(cache: cache)
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
        let uiUpdateCompletion: () -> Void = { [weak listView, weak activityLoader, weak refresher] in
            listView?.reloadData()
            activityLoader?.stopAnimating()
            refresher?.endRefreshing()
        }

        let renderCompletion: () -> Void = {
            executeMainThreadUpdate(using: uiUpdateCompletion)
        }

        dataSource.render(completion: renderCompletion)
    }

    @objc
    func refreshList() {
        dataSource.resetStorage()
        viewModel.requestRandomCharacters()
    }
}

extension MainListViewController: ListDelegate {
    func didSelected(at index: Int) {
        let selectedCharacter = dataSource.selectedCharacter(at: index)

        viewModel.checkDetails(for: selectedCharacter)
    }
}
