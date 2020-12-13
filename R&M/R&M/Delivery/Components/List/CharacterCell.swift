//
//  CharacterCell.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = LabelBuilder.assemble(textStyle: .callout)
    private lazy var subtitleLabel: UILabel = LabelBuilder.assemble(textStyle: .footnote)
    private lazy var descriptionStackView: UIStackView = {
        StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [titleLabel, subtitleLabel],
                                                  alignment: .leading))
    }()

    private lazy var thumbnailPlaceholderView: UIView = {
        let placeholderView = UIView()
        placeholderView.backgroundColor = .systemBlue

        placeholderView
            .heightAnchor
            .constraint(equalToConstant: contentView.bounds.height * 0.5)
            .isActive = true
        placeholderView
            .widthAnchor
            .constraint(equalTo: placeholderView.heightAnchor)
            .isActive = true

        return placeholderView
    }()

    private lazy var containerStackView: UIStackView = {
        StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [thumbnailPlaceholderView, descriptionStackView],
                                                  axis: .horizontal,
                                                  alignment: .center))
    }()


    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(containerStackView, constraints: [
            pinAllEdges(margin: 16)
        ])
        thumbnailPlaceholderView.rounded()
    }

    func setInformation(_ information: CharacterDTO) {
        titleLabel.text = information.name
        subtitleLabel.text = information.status
    }

    func setRelatedInformation(_ information: CharacterDTO) {
        titleLabel.text = information.name
        subtitleLabel.text = information.species
    }
}
