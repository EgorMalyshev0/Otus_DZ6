//
//  SuffixWidgetTimeline.swift
//  SuffixWidgetExtension
//
//  Created by Egor Malyshev on 04.11.2021.
//

import SwiftUI
import WidgetKit

struct SuffixWidgetTimeline: TimelineProvider {
    
    func placeholder(in context: Context) -> SuffixWidgetEntry {
        SuffixWidgetEntry()
    }

    func getSnapshot(in context: Context, completion: @escaping (SuffixWidgetEntry) -> ()) {
        let entry = SuffixWidgetEntry()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SuffixWidgetEntry>) -> ()) {
        let suffixes = getSuffixes() ?? []
        let entries = [SuffixWidgetEntry(suffixes: suffixes)]

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
    
    func getSuffixes() -> [SuffixItem]? {
        let url = AppGroup.info.containerURL.appendingPathComponent("contents.json")
        if let data = try? Data(contentsOf: url) {
            return try? JSONDecoder().decode([SuffixItem].self, from: data)
        }
        return []
    }
    
}
