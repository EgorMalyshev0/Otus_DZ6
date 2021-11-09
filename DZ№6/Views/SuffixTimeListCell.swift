//
//  SuffixTimeListCell.swift
//  DZ№6
//
//  Created by Egor Malyshev on 09.11.2021.
//

import SwiftUI

struct SuffixTimeListCell: View {
    
    var suffixItem: SuffixItem
    
    var body: some View {
        HStack{
            Text("\(suffixItem.name)")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(suffixItem.searchTime) s")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        
    }
}
