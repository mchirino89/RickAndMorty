//
//  LoaderBuilder.swift
//  R&M
//
//  Created by Mauricio Chirino on 15/12/20.
//

import UIKit

struct LoaderBuilder {
    static func assemble(style: UIActivityIndicatorView.Style = .large) -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView(style: style)
        loader.startAnimating()
        loader.color = .systemBlue

        return loader
    }
}
