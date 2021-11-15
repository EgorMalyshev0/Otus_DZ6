//
//  Suffix.swift
//  DZ№6
//
//  Created by Egor Malyshev on 10.11.2021.
//

import Foundation

struct Suffix: Hashable {
    let id = UUID().uuidString
    let name: String
    let searchTime: TimeInterval
}
