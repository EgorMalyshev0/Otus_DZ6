//
//  SuffixJobSchedular.swift
//  DZ№6
//
//  Created by Egor Malyshev on 09.11.2021.
//

import Foundation

class SuffixJobSchedular {
    
    typealias FinishCallback = (([SuffixItem]) -> Void)
    
    var completion: FinishCallback
    
    let characterSet = CharacterSet(charactersIn: ".,:!?-()[]{}/\" ")
    
    init(completion: @escaping FinishCallback) {
        self.completion = completion
    }
    
    func execute(with text: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else {return}
            let startTime = Date()
            print("Starting work with text. Text count: \(text.count)\n")
            let words = text.components(separatedBy: self.characterSet)
            let seqs = words.map{WordSequence(word: $0)}
            var arr: [String] = []
            for s in seqs {
                arr.append(contentsOf: s.map{$0})
            }
            print("Suffix count: \(arr.count)\n")
            let dictionary = Dictionary(grouping: arr, by: {$0})
            print("\nGrouped suffix count: \(dictionary.count)\n")
            print("Terminating time: \(Date().timeIntervalSince(startTime)) s")
            let suffixes = dictionary.map{SuffixItem(name: $0.key, count: $0.value.count)}
            DispatchQueue.main.async {
                self.completion(suffixes)
                NotificationCenter.default.post(name: NSNotification.suffixSearchFinished.name, object: nil)
            }
        }
    }
}
