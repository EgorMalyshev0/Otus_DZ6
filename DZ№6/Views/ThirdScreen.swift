//
//  ThirdScreen.swift
//  DZ№6
//
//  Created by Egor Malyshev on 04.11.2021.
//

import SwiftUI

struct ThirdScreen: View {
    
    @EnvironmentObject var suffixViewModel: SuffixViewModel

    var body: some View {
        List(suffixViewModel.timeSortedSuffixes) { item in
            SuffixTimeListCell(suffixItem: item, color: color(of: item))
        }
    }
    
    func color(of item: SuffixItem) -> UIColor {
        if item.id == suffixViewModel.timeSortedSuffixes.last?.id {
            return .red
        }
        if item.id == suffixViewModel.timeSortedSuffixes.first?.id {
            return .green
        }
        return .label
    }
}
