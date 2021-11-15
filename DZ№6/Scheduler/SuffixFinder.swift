//
//  SuffixFinder.swift
//  DZ№6
//
//  Created by Egor Malyshev on 15.11.2021.
//

import Foundation

class SuffixFinder: Operation {
    
    let word: String
    let suffixNumber: Int
    var suffix: String = ""
    
    override var isAsynchronous: Bool {
        return true
    }
    
    init(word: String, suffixNumber: Int) {
        self.word = word
        self.suffixNumber = suffixNumber
    }
    
    override func main() {
        suffix = String(word.suffix(suffixNumber))
    }
}
