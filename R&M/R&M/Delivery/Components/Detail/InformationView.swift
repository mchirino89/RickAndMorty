//
//  InformationView.swift
//  R&M
//
//  Created by Mauricio Chirino on 13/12/20.
//

import MauriKit
import UIKit

private enum Card: String {
    case name
    case species
    case origin
    case status

    var value: String {
        rawValue.capitalized
    }
}

final class InformationView: UIView {
    private let avatarImageView: UIImageView = UIImageView(image: AssetCatalog.placeholder.image)

    private lazy var containerStackView: UIStackView = {
        StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [avatarImageView],
                                                  spacing: UIConstants.fullPadding,
                                                  alignment: .center))
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        viewLayoutSetup()
    }

    func render(basedOn character: ImageSourceable, with avatarImage: UIImage) {
        containerStackView.addArrangedSubview(buildCard(tag: Card.name.value,
                                                        content: character.title,
                                                        textStyle: .title3))
        containerStackView.addArrangedSubview(buildCard(tag: Card.species.value, content: character.species))
        containerStackView.addArrangedSubview(buildCard(tag: Card.origin.value, content: character.origin))
        containerStackView.addArrangedSubview(buildCard(tag: Card.status.value, content: character.subtitle))

        let speciesTitle = LabelBuilder.assemble(textStyle: .title3, text: "Other similar species")
        speciesTitle.textAlignment = .left
        containerStackView.addArrangedSubview(speciesTitle)
        avatarImageView.image = avatarImage
    }
}

private extension InformationView {
    func buildCard(tag: String, content: String, textStyle: UIFont.TextStyle = .callout) -> UIStackView {
        let tagLabel = LabelBuilder.assemble(textStyle: .callout, text: tag)
        tagLabel.textAlignment = .right
        let contentLabel = LabelBuilder.assemble(textStyle: textStyle, text: content)
        contentLabel.textAlignment = .left

        return StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [tagLabel, contentLabel],
                                                         axis: .horizontal,
                                                         distribution: .fillEqually))
    }

    func viewLayoutSetup() {
        self.addSubview(containerStackView, constraints: [
            pinAllEdges(margin: UIConstants.standardPadding)
        ])

        avatarImageView
            .heightAnchor
            .constraint(equalToConstant: bounds.height * 0.33)
            .isActive = true
        avatarImageView
            .widthAnchor
            .constraint(equalTo: avatarImageView.heightAnchor)
            .isActive = true
        avatarImageView.rounded()
    }
}
