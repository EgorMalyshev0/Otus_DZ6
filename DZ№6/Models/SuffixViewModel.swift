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
            findTop10Suffixes()
        }
    }
    @Published var sortedSuffixes: [SuffixItem] = .init()
    @Published var top10TripleSuffixes: [SuffixItem] = .init()
    @Published var isLoading: Bool = false
    
    lazy var schedular = SuffixJobSchedular() { [weak self] suffixes in
        self?.suffixes = suffixes
        self?.isLoading = false
    }
    
    private func findSortedSuffixes() {
        sortedSuffixes = Array(suffixes.sorted(by: {$0.name < $1.name}))
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
