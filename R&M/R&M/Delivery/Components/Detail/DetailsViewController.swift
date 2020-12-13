//
//  DetailsViewController.swift
//  R&M
//
//  Created by Mauricio Chirino on 12/12/20.
//

import UIKit

final class DetailsViewController: UIViewController {
    private lazy var informationView: InformationView = {
        let dummyView = InformationView()
        dummyView.backgroundColor = .clear
        return dummyView
    }()

    private lazy var detailView: DetailContentView = {
        let details = DetailContentView(frame: view.frame)
        details.dataSource = self

        return details
    }()

    private lazy var containerStackView: UIStackView = {
        StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [informationView, detailView],
                                                  spacing: 0,
                                                  alignment: .fill))
    }()

    private let viewModel: CharacterViewModel

    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(containerStackView, constraints: [
            pinAllEdges()
        ])

        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        informationView.render(basedOn: viewModel.character)
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let characterCell: CharacterCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailContentView.cellIdentifier,
                                                               for: indexPath) as! CharacterCell

        characterCell.setRelatedInformation(viewModel.character)
        return characterCell
    }

}
