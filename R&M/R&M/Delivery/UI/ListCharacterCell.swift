//
//  ListCharacterCell.swift
//  R&M
//
//  Created by Mauricio Chirino on 08/12/20.
//

import UIKit

final class ListCharacterCell: UICollectionViewCell {
    private lazy var nameLabel: UILabel = buildLabel(textStyle: .callout)
    private lazy var statusLabel: UILabel = buildLabel(textStyle: .footnote)

    private lazy var descriptionStackView = buildStackView(for: [nameLabel,
                                                                 statusLabel],
                                                           alignment: .leading)

    private lazy var thumbnailPlaceholderView: UIView = {
        let placeholderView = UIView()
        placeholderView.backgroundColor = .blue

        placeholderView
            .heightAnchor
            .constraint(equalToConstant: contentView.bounds.height * 0.66)
            .isActive = true
        placeholderView
            .widthAnchor
            .constraint(equalTo: placeholderView.heightAnchor)
            .isActive = true

        return placeholderView
    }()

    private lazy var containerStackView = buildStackView(for: [thumbnailPlaceholderView,
                                                               descriptionStackView],
                                                         axis: .horizontal,
                                                         alignment: .center)

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(containerStackView, constraints: [
            pinAllEdges(margin: UIConstants.standardPadding)
        ])
        roundImage()
    }

    func setInformation(_ information: CharacterDTO) {
        nameLabel.text = information.name
        statusLabel.text = information.status
    }
}

private extension ListCharacterCell {
    func buildLabel(textStyle: UIFont.TextStyle,
                    backgroundColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.textColor = .darkText
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.75
        label.backgroundColor = backgroundColor
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


