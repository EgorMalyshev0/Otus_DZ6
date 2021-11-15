//
//  SuffixItem.swift
//  DZ№6
//
//  Created by Egor Malyshev on 05.11.2021.
//

import Foundation
import WidgetKit

struct SuffixItem: Identifiable, Codable {
    let name: String
    let count: Int
    var id = UUID().uuidString
    let searchTime: TimeInterval
}
