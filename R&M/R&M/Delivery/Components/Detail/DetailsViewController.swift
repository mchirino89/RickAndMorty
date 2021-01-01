//
//  DetailsViewController.swift
//  R&M
//
//  Created by Mauricio Chirino on 12/12/20.
//

import MauriKit
import UIKit

final class DetailsViewController: UIViewController {
    private let informationView: InformationView = InformationView()

    private lazy var detailView: DetailContentView = {
        let details = DetailContentView(frame: view.frame)
        details.dataSource = dataSource
        details.prefetchDataSource = dataSource

        return details
    }()

    private lazy var containerStackView: UIStackView = {
        StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [informationView, detailView],
                                                  spacing: 0,
                                                  alignment: .fill))
    }()

    private let viewModel: DetailsViewModel
    private let dataSource: CharacterDataSource

    init(charactersRepo: CharacterStorable, currentCharacter: CharacterDTO, cache: Cacheable) {
        dataSource = CharacterDataSource(cache: cache)
        viewModel = DetailsViewModel(dataSource: dataSource,
                                     charactersRepo: charactersRepo,
                                     currentCharacter: currentCharacter)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        renderView()
        renderCoincidences()
    }

    deinit {
        print("Properly dealloc. No retain cycles")
    }
}

private extension DetailsViewController {
    func setup() {
        title = DetailsDictionary.title.rawValue
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(containerStackView, constraints: [
            pinAllEdges()
        ])

        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
    }

    func renderView() {
        informationView.render(basedOn: viewModel.currentCharacter,
                               with: dataSource.cachedImage(for: viewModel.currentCharacter.avatar))
        viewModel.fetchRelatedSpecies()
        containerStackView.layoutIfNeeded()
    }

    func renderCoincidences() {
        let uiUpdateCompletion: () -> Void = { [weak detailView] in
            detailView?.reloadData()
        }

        let renderCompletion: () -> Void = {
            performUIUpdate(using: uiUpdateCompletion)
        }

        dataSource.render(completion: renderCompletion)
    }
}
