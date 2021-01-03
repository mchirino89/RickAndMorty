//
//  CardSourceable.swift
//  R&M
//
//  Created by Mauricio Chirino on 03/01/21.
//

import Foundation

public protocol CardSourceable: CachedThumbnail {
    var title: String { get }
    var subtitle: String { get }
    // TODO: these attributes below shouldn't be part of generic data
    var species: String { get }
    var origin: String { get }
}
