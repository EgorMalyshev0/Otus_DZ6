//
//  SuffixTimeListCell.swift
//  DZ№6
//
//  Created by Egor Malyshev on 09.11.2021.
//

import SwiftUI

struct SuffixTimeListCell: View {
    
    var suffixItem: SuffixItem
    var color: UIColor
    
    var body: some View {
        HStack{
            Text("\(suffixItem.name)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(color))
            Text("\(time ?? "0") s")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(Color(color))
        }
        
    }
    
    var time: String? {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 12
        let number = NSNumber(floatLiteral: suffixItem.searchTime)
        return formatter.string(from: number)
    }
}
