//
//  InformationView.swift
//  R&M
//
//  Created by Mauricio Chirino on 13/12/20.
//

import UIKit

final class InformationView: UIView {
    private lazy var avatarImageView: UIView = {
        let placeholderView = UIView()
        placeholderView.backgroundColor = .blue

        return placeholderView
    }()

    private lazy var containerStackView: UIStackView = {
        StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [avatarImageView], alignment: .center))
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        viewLayoutSetup()
    }

    func render(basedOn character: CharacterDTO) {
        containerStackView.addArrangedSubview(buildCard(tag: "Name",
                                                        content: character.name))
        containerStackView.addArrangedSubview(buildCard(tag: "Species",
                                                        content: character.species))
        containerStackView.addArrangedSubview(buildCard(tag: "Origin",
                                                        content: character.origin))
        containerStackView.addArrangedSubview(buildCard(tag: "Status",
                                                        content: character.status))
    }
}

private extension InformationView {
    func buildCard(tag: String, content: String) -> UIStackView {
        let tagLabel = LabelBuilder.assemble(textStyle: .callout, text: tag)
        tagLabel.textAlignment = .right
        let contentLabel = LabelBuilder.assemble(textStyle: .callout, text: content)
        contentLabel.textAlignment = .left

        return StackBuilder.assemble(basedOn: StackSetup(arrangedSubviews: [tagLabel, contentLabel],
                                                         axis: .horizontal,
                                                         distribution: .fillEqually))
    }

    func viewLayoutSetup() {
        self.addSubview(containerStackView, constraints: [
            pinAllEdges(margin: 16)
        ])

        avatarImageView
            .heightAnchor
            .constraint(equalToConstant: bounds.height * 0.5)
            .isActive = true
        avatarImageView
            .widthAnchor
            .constraint(equalTo: avatarImageView.heightAnchor)
            .isActive = true
        avatarImageView.rounded()
        avatarImageView.layoutIfNeeded()
    }
}
