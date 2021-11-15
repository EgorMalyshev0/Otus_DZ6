//
//  ThreadSafeArray.swift
//  DZ№6
//
//  Created by Egor Malyshev on 15.11.2021.
//

import Foundation

class ThreadSafeArray<T> {
    private var internalArray: [T] = []
    
    let isolationQueue = DispatchQueue(label: "isolationQueue", attributes: [.concurrent])
    
    func append(_ element: T) {
        isolationQueue.async(flags: .barrier) {
            self.internalArray.append(element)
        }
    }
    
    func clean() {
        isolationQueue.async(flags: .barrier) {
            self.internalArray.removeAll()
        }
    }
    
    var content: [T] {
        var result: [T] = []
        isolationQueue.sync {
            result = self.internalArray
        }
        return result
    }
}
