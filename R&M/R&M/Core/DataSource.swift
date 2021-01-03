//
//  DataSource.swift
//  R&M
//
//  Created by Mauricio Chirino on 14/12/20.
//

import Foundation

public class DataSource<T>: NSObject {
    public var data: Dynamic<[T]>

    override public init() {
        data = Dynamic([])
    }
}
