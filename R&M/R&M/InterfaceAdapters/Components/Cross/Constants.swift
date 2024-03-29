//
//  Constants.swift
//  R&M
//
//  Created by Mauricio Chirino on 10/12/20.
//

import UIKit

// This could very well match keys from a localized .string file
enum ListDictionary: String {
    case title = "Rick and Morty"
    case refreshHint = "Looking for more characters"
}

enum DetailsDictionary: String {
    case title = "Details"
    case otherSpecies = "Other similar species"
}

enum ColorCatalogue: String {
    case text

    var color: UIColor? {
        UIColor(named: rawValue)
    }
}

enum AssetCatalog {
    case placeholder

    var image: UIImage {
        switch self {
        case .placeholder:
            return UIImage(named: "placeholder")!
        }
    }
}
