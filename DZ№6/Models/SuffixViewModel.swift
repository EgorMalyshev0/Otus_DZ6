//
//  SuffixViewModel.swift
//  DZ№6
//
//  Created by Egor Malyshev on 04.11.2021.
//

import Foundation
import WidgetKit

class SuffixViewModel: ObservableObject {
    
    @Published var suffixes: [SuffixItem] = .init() {
        didSet {
            findSortedSuffixes()
            findTimeSortedSuffixes()
            findTop10Suffixes()
        }
    }
    @Published var sortedSuffixes: [SuffixItem] = .init()
    @Published var timeSortedSuffixes: [SuffixItem] = .init()
    @Published var top10TripleSuffixes: [SuffixItem] = .init()
    @Published var isLoading: Bool = false
    
    lazy var schedular = SuffixJobScheduler() { [weak self] suffixes in
        self?.suffixes = suffixes
        self?.isLoading = false
    }
    
    private func findSortedSuffixes() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let array = Array(self.suffixes.sorted(by: {$0.name < $1.name}))
            DispatchQueue.main.async {
                self.sortedSuffixes = array
            }
        }
    }
    
    private func findTimeSortedSuffixes() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let array = Array(self.suffixes.sorted(by: {$0.searchTime < $1.searchTime}))
            DispatchQueue.main.async {
                self.timeSortedSuffixes = array
            }
        }
    }
    
    private func findTop10Suffixes() {
        let filteredSuffixes = suffixes.filter{$0.name.count == 3}
        top10TripleSuffixes = Array(filteredSuffixes.sorted(by: {$0.count > $1.count}).prefix(10))
        saveSuffixesToWidget()
    }
    
    func saveSuffixesToWidget() {
        let top3 = Array(top10TripleSuffixes.prefix(3))
        let url = AppGroup.info.containerURL.appendingPathComponent("contents.json")
        if let data = try? JSONEncoder().encode(top3) {
            do {
                try data.write(to: url)
                WidgetCenter.shared.reloadTimelines(ofKind: "SuffixWidget2")
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    func performSearch(with text: String) {
        isLoading = true
        schedular.execute(with: text)
    }
    
}
