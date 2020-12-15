//
//  DataSource.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation

class DataSource<T>: NSObject {
    var data: Dynamic<[T]>

    override init() {
        data = Dynamic([])
    }
}
