//
//  WordSequence.swift
//  DZ№6
//
//  Created by Egor Malyshev on 04.11.2021.
//

import Foundation

struct WordSequence: Sequence {
    let word: String

    func makeIterator() -> WordIterator {
        return WordIterator(self)
    }
}

struct WordIterator: IteratorProtocol {
    let wordSequence: WordSequence
    var currentSuffix: Int = 0

    init(_ wordSequence: WordSequence) {
        self.wordSequence = wordSequence
    }

    mutating func next() -> String? {
        let nextIndex = currentSuffix + 1
        guard nextIndex <= wordSequence.word.count else { return nil }
        currentSuffix += 1
        return String(wordSequence.word.suffix(currentSuffix)).lowercased()
    }
}
