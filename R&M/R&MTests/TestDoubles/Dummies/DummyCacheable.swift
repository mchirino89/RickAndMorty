//
//  DummyCacheable.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 16/12/20.
//

import UIKit
@testable import R_M

final class DummyCacheable: Cacheable {
    func object(at key: String) -> UIImage? {
        return UIImage(named: "rick", in: Bundle(for: Self.self), compatibleWith: nil)
    }

    func store(image: UIImage, at key: String) {
    }
    
    func reset() {
    }
}
