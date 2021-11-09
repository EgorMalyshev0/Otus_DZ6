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
            SuffixTimeListCell(suffixItem: item)
        }
    }
}
