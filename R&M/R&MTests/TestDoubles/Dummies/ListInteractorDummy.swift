//
//  ListInteractorDummy.swift
//  R&MTests
//
//  Created by Mauricio Chirino on 14/12/20.
//

import UIKit
@testable import R_M

struct ListInteractorDummy: ListInteractable {
    var listView: UIView?

    var delegate: ListDelegate?
}
