//
//  Constants.swift
//  R&M
//
//  Created by Mauricio Chirino on 10/12/20.
//

import UIKit

struct UIConstants {
    static let standardPadding: CGFloat = 8
}

enum ColorCatalogue: String {
    case text = "text"

    var color: UIColor? {
        UIColor(named: rawValue)
    }
}
