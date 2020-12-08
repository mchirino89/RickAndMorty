//
//  MainListViewController.swift
//  R&M
//
//  Created by Mauricio Chirino on 06/12/20.
//

import UIKit

final class MainListViewController: UIViewController {
    private let standardPadding: CGFloat = 16
    private let cellIdentifier: String = "MyCell"
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
        view.backgroundColor = .white
        title = "Rick and Morty"
        view.addSubview(listView)
    }
}

extension MainListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int { 10 }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                        for: indexPath)
        myCell.backgroundColor = .blue
        return myCell
    }
}

private extension MainListViewController {
    private func buildList() -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: view.safeAreaInsets.top + 16,
                                           left: view.safeAreaInsets.left + 16,
                                           bottom: view.safeAreaInsets.bottom + 16,
                                           right: view.safeAreaInsets.right + 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 60)
        let mainCollectionView = UICollectionView(frame: view.safeAreaLayoutGuide.layoutFrame,
                                                  collectionViewLayout: layout)

        mainCollectionView.register(UICollectionViewCell.self,
                                    forCellWithReuseIdentifier: cellIdentifier)
        mainCollectionView.backgroundColor = .white
        mainCollectionView.dataSource = self

        return mainCollectionView
    }
}

final class CustomCell: UICollectionViewCell {
    private lazy var nameLabel: UILabel = buildLabel(textStyle: .title1)
    private lazy var originLabel: UILabel = buildLabel(textStyle: .title2,
                                                       backgroundColor: .red)
    private lazy var statusLabel: UILabel = buildLabel(textStyle: .title2,
                                                       backgroundColor: .yellow)
    private static let halfPadding: CGFloat = 8

    private lazy var descriptionStackView = buildStackView(for: [nameLabel,
                                                                 originLabel,
                                                                 statusLabel],
                                                           alignment: .leading)

    private lazy var thumbnailPlaceholderView: UIView = {
        let frameDimension = CGRect(origin: .zero, size: CGSize(width: 48, height: 48))
        let placeholderView = UIView(frame: frameDimension)
        placeholderView.backgroundColor = .green

        return placeholderView
    }()

    private lazy var containerStackView = buildStackView(for: [thumbnailPlaceholderView,
                                                               descriptionStackView],
                                                         axis: .horizontal,
                                                         alignment: .center)

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(containerStackView, constraints: [
            pinAllEdges(margin: CustomCell.halfPadding)
        ])
    }

    func setInformation(_ information: CharacterDTO) {
        nameLabel.text = information.name
//        originLabel.text = information.origin.name
        statusLabel.text = information.status
    }
}

private extension CustomCell {
    func buildLabel(textStyle: UIFont.TextStyle,
                    backgroundColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.textColor = .darkText
        label.backgroundColor = backgroundColor
        label.font = .preferredFont(forTextStyle: textStyle)

        return label
    }

    func buildStackView(for arrangedSubviews: [UIView],
                        axis: NSLayoutConstraint.Axis = .vertical,
                        spacing: CGFloat = halfPadding,
                        alignment: UIStackView.Alignment,
                        distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution

        return stackView
    }
}
