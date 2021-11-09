//
//  DZ_6App.swift
//  DZ№6
//
//  Created by Egor Malyshev on 04.11.2021.
//

import SwiftUI

@main
struct DZ_6App: App {
    
    @ObservedObject var router: Router = .init()
    @ObservedObject var suffixViewModel: SuffixViewModel = .init()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
                .environmentObject(suffixViewModel)
                .onOpenURL { url in
                    let index = Int(url.host?.removingPercentEncoding ?? "0")
                    router.selection = Int(index ?? 0)
                }
        }
    }
}
