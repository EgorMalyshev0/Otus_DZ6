//
//  SecondScreen.swift
//  DZ№6
//
//  Created by Egor Malyshev on 04.11.2021.
//

import SwiftUI

struct SecondScreen: View {
    
    enum SuffixesDisplayType: String, CaseIterable {
        case all = "All", top10 = "Top-10"
    }
    enum SuffixesSortType: String, CaseIterable {
        case asc = "ASC", top10 = "DESC"
    }
    
    @EnvironmentObject var suffixViewModel: SuffixViewModel
    @State private var selectedDisplayType: SuffixesDisplayType = .all
    @State private var selectedSortType: SuffixesSortType = .asc
    
    var body: some View {
        VStack {
            if !suffixViewModel.suffixes.isEmpty {
                Picker("Choose display type for founded suffixes", selection: $selectedDisplayType) {
                    ForEach(SuffixesDisplayType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                if selectedDisplayType == .all {
                    Picker("Choose sort type", selection: $selectedSortType) {
                        ForEach(SuffixesSortType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                switch selectedDisplayType {
                case .all:
                    let list = selectedSortType == .asc ? suffixViewModel.sortedSuffixes : suffixViewModel.sortedSuffixes.reversed()
                    List(list) { item in
                        SuffixListCell(suffixItem: item)
                    }
                case .top10:
                    List(suffixViewModel.top10TripleSuffixes) { item in
                        SuffixListCell(suffixItem: item)
                    }
                }
            } else {
                Text("No suffixes")
            }
        }
    }
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen()
    }
}
