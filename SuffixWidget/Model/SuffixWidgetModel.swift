//
//  SuffixWidgetModel.swift
//  SuffixWidgetExtension
//
//  Created by Egor Malyshev on 04.11.2021.
//

import Foundation
import WidgetKit

struct SuffixWidgetEntry: TimelineEntry {
    var date: Date = Date()
    
    var suffixes: [SuffixItem] = []
}
