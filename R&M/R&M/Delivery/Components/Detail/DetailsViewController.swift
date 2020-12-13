//
//  DetailsViewController.swift
//  R&M
//
//  Created by Mauricio Chirino on 12/12/20.
//

import UIKit

struct CharacterDummyDTO: Hashable {
    let id: Int
    let name: String
    let origin: String
    let species: String
    let status: String
    let avatar: UIImage?
    let episodes: [String]
}

final class DetailsViewController: UIViewController {
    let characterDataSource: CharacterDummyDTO = CharacterDummyDTO(id: 1,
                                                         name: "Rick Sanchez",
                                                         origin: "Earth",
                                                         species: "Human",
                                                         status: "Alive",
                                                         avatar: UIImage(named: "rick.jpg"),
                                                         episodes: ["pilot", "rickadele", "pickle rick"])
    private lazy var detailView: DetailContentView = {
        let details = DetailContentView(frame: view.frame)
        details.dataSource = self

        return details
    }()

    private lazy var informationView: UIView = {
        let dummyView = UIView()
        dummyView.backgroundColor = .red
        return dummyView
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [informationView, detailView])
        stackView.distribution = .fill
//        stackView.spacing = 16
        stackView.axis = .vertical
//        stackView.alignment = .fill

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(containerStackView, constraints: [
            pinAllEdges(margin: 16)
        ])

        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
    }

}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailContentView.cellIdentifier,
                                                               for: indexPath) as! CharacterCell

        characterCell.setRelatedInformation(characterDataSource)
        return characterCell
    }

}
