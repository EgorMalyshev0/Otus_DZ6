//
//  SuffixListCell.swift
//  DZ№6
//
//  Created by Egor Malyshev on 04.11.2021.
//

import SwiftUI

struct SuffixListCell: View {
    
    var suffixItem: SuffixItem
    
    var body: some View {
        HStack {
            Text("\(suffixItem.name)")
            if suffixItem.count > 1 {
                Text("x\(suffixItem.count)")
                    .foregroundColor(.red)
            }
        }
    }
}
