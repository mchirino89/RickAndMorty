//
//  Constants.swift
//  R&M
//
//  Created by Mauricio Chirino on 10/12/20.
//

import UIKit

struct UIConstants {
    static let standardPadding: CGFloat = 8
    static let fullPadding: CGFloat = 8
}

// This could very well match keys from a localized .string file
enum ListDictionary: String {
    case title = "Rick and Morty"
}

enum DetailsDictionary: String {
    case title = "Details"
    case otherSpecies = "Other similar species"
}

enum ColorCatalogue: String {
    case text = "text"

    var color: UIColor? {
        UIColor(named: rawValue)
    }
}
