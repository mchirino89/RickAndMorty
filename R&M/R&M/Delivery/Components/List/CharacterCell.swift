//
//  CharacterCell.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import MauriKit
import MauriUtils
import UIKit

protocol ListableCell where Self: UICollectionViewCell {
    func setThumbnail(image: UIImage)
    func setInformation(_ information: CardSourceable)
}

final class CharacterCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = LabelBuilder.assemble(textStyle: .callout)
    private lazy var subtitleLabel: UILabel = LabelBuilder.assemble(textStyle: .footnote)
    private lazy var descriptionStackView: UIStackView = {
        StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [titleLabel, subtitleLabel],
                                                  alignment: .leading))
    }()

    private lazy var activityLoader: UIActivityIndicatorView = LoaderBuilder.assemble(style: .medium)

    private lazy var thumbnailView: UIImageView = {
        let smallImageView = UIImageView(image: AssetCatalog.placeholder.image)

        smallImageView
            .heightAnchor
            .constraint(equalToConstant: contentView.bounds.height * 0.5)
            .isActive = true
        smallImageView
            .widthAnchor
            .constraint(equalTo: smallImageView.heightAnchor)
            .isActive = true

        smallImageView.addSubview(activityLoader, constraints: [
            pinToCenter()
        ])

        return smallImageView
    }()

    private lazy var containerStackView: UIStackView = {
        StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [thumbnailView, descriptionStackView],
                                                  axis: .horizontal,
                                                  alignment: .center))
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(containerStackView, constraints: [
            pinAllEdges(margin: 16)
        ])
        thumbnailView.rounded()
    }
}

extension CharacterCell: ListableCell {
    func setInformation(_ information: CardSourceable) {
        titleLabel.text = information.title
        subtitleLabel.text = information.subtitle
    }

    func setThumbnail(image: UIImage) {
        executeMainThreadUpdate { [weak activityLoader, weak thumbnailView] in
            activityLoader?.stopAnimating()
            thumbnailView?.image = image
        }
    }
}
