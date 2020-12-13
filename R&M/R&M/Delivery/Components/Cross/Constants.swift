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

// This could very well match keys from a localized .string file
enum Dictionary: String {
    case mainTitle = "Rick and Morty"
}

enum ColorCatalogue: String {
    case text = "text"

    var color: UIColor? {
        UIColor(named: rawValue)
    }
}
