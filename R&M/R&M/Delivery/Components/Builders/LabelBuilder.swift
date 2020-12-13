//
//  LabelBuilder.swift
//  R&M
//
//  Created by Mauricio Chirino on 13/12/20.
//

import UIKit

struct LabelBuilder {
    static func assemble(textStyle: UIFont.TextStyle, backgroundColor: UIColor = .white) -> UILabel {
        let label = UILabel()
        label.textColor = ColorCatalogue.text.color
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.75
        label.backgroundColor = .clear
        label.font = .preferredFont(forTextStyle: textStyle)

        return label
    }
}
