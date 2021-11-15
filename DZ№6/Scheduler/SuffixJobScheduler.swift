//
//  SuffixJobScheduler.swift
//  DZ№6
//
//  Created by Egor Malyshev on 09.11.2021.
//

import UIKit

class SuffixJobScheduler {
    
    typealias FinishCallback = (([SuffixItem]) -> Void)
    
    var completion: FinishCallback
    
    let characterSet = CharacterSet(charactersIn: ".,:!?-()[]{}/\" ")
        
    let operationQueue = OperationQueue()
    
    var suffixes: ThreadSafeArray<Suffix> = .init()

    init(completion: @escaping FinishCallback) {
        self.completion = completion
    }
    
    private func findSuffix(in word: String, count: Int, completion: @escaping ((String) -> Void)) {
        let suffix = String(word.suffix(count))
        completion(suffix)
    }
    
    private func findSuffixes(in words: [String], completion: @escaping ([SuffixItem]) -> ()) {
        words.forEach { word in
            let startTime = Date()
            guard word.count > 0 else { return }
            for i in (1...word.count) {
                let operation = SuffixFinder(word: word, suffixNumber: i)
                operation.completionBlock = {
                    let time = Date().timeIntervalSince(startTime)
                    self.suffixes.append(Suffix(name: operation.suffix.lowercased(), searchTime: time))
                }
                operationQueue.addOperation(operation)
            }
        }
        operationQueue.waitUntilAllOperationsAreFinished()
        Thread.sleep(forTimeInterval: 0.01)
        let dictionary = Dictionary(grouping: self.suffixes.content, by: {$0})
        let suffixItems = dictionary.map{SuffixItem(name: $0.key.name, count: $0.value.count, searchTime: $0.key.searchTime)}
        completion(suffixItems)
    }
    
    func execute(with text: String) {
        suffixes.clean()
        DispatchQueue.global().async { [unowned self] in
            print("Starting suffixes search...")
            let globalTime = Date()
            let words = text.components(separatedBy: self.characterSet)
            self.findSuffixes(in: words) { suffixes in
                DispatchQueue.main.async {
                    print("Finished! Execution time: \(Date().timeIntervalSince(globalTime))")
                    self.completion(suffixes)
                    NotificationCenter.default.post(name: NSNotification.suffixSearchFinished.name, object: nil)
                }
            }
        }
    }
}
