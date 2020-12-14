//
//  UIImageView+Round.swift
//  R&M
//
//  Created by Mauricio Chirino on 13/12/20.
//

import UIKit

#warning("Replace below extension with this one for later tests")
extension UIImageView {
    func roundImage() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layoutIfNeeded()
    }
}

// TODO: remove
extension UIView {
    /// Turn current component into a rounded one (works properly if aspect ratio is 1:1)
    func rounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layoutIfNeeded()
    }
}