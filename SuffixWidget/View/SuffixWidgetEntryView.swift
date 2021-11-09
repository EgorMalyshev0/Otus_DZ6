//
//  SuffixWidgetEntryView.swift
//  SuffixWidgetExtension
//
//  Created by Egor Malyshev on 04.11.2021.
//

import SwiftUI
import WidgetKit

struct SuffixWidgetEntryView : View {
    var entry: SuffixWidgetTimeline.Entry
    
    var body: some View {
        VStack(spacing: 16){
            if entry.suffixes.isEmpty {
                Text("No suffixes")
                    .font(.subheadline)
            } else {
                VStack(spacing: 6){
                    Text("Top-3 three letter suffixes:")
                        .font(.subheadline)
                    HStack(spacing: 12){
                        ForEach(entry.suffixes) { item in
                            Text("\(item.name) - \(item.count)")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            HStack{
                Link(destination: URL(string: "widget-deeplink://0")!) {
                    Text("FirstTab")
                        .foregroundColor(.red)
                }
                Link(destination: URL(string: "widget-deeplink://1")!) {
                    Text("SecondTab")
                        .foregroundColor(.red)
                }
                Link(destination: URL(string: "widget-deeplink://2")!) {
                    Text("ThirdTab")
                        .foregroundColor(.red)
                }
            }
        }
    }
    
}

struct SuffixWidget_Previews: PreviewProvider {
    static var previews: some View {
        SuffixWidgetEntryView(entry: SuffixWidgetEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
