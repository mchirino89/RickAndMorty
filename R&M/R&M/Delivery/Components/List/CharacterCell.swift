//
//  CharacterCell.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = buildLabel(textStyle: .callout)
    private lazy var subtitleLabel: UILabel = buildLabel(textStyle: .footnote)
    private lazy var descriptionStackView = buildStackView(for: [titleLabel, subtitleLabel], alignment: .leading)

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

    private lazy var containerStackView = buildStackView(for: [thumbnailPlaceholderView, descriptionStackView],
                                                         axis: .horizontal,
                                                         alignment: .center)

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(containerStackView, constraints: [
            pinAllEdges(margin: 16)
        ])
        roundImage()
    }

    func setInformation(_ information: CharacterDTO) {
        titleLabel.text = information.name
        subtitleLabel.text = information.status
    }

    func setRelatedInformation(_ information: CharacterDummyDTO) {
        titleLabel.text = information.name
        subtitleLabel.text = information.species
    }
}

private extension CharacterCell {
    func buildLabel(textStyle: UIFont.TextStyle, backgroundColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.textColor = ColorCatalogue.text.color
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.75
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: textStyle)

        return label
    }

    func buildStackView(for arrangedSubviews: [UIView],
                        axis: NSLayoutConstraint.Axis = .vertical,
                        spacing: CGFloat = UIConstants.standardPadding,
                        alignment: UIStackView.Alignment,
                        distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution

        return stackView
    }

    private func roundImage() {
        thumbnailPlaceholderView.layer.masksToBounds = false
        thumbnailPlaceholderView.layer.cornerRadius = thumbnailPlaceholderView.frame.height / 2
        thumbnailPlaceholderView.clipsToBounds = true
        thumbnailPlaceholderView.layoutIfNeeded()
    }
}


