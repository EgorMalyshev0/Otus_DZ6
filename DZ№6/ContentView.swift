//
//  ContentView.swift
//  DZ№6
//
//  Created by Egor Malyshev on 04.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var suffixViewModel: SuffixViewModel

    var body: some View {
        TabView(selection: $router.selection) {
            FirstScreen()
                .tabItem {
                    Text("First")
                    Image(systemName: "1.circle")
                }
                .tag(TabType.first.rawValue)
                .environmentObject(suffixViewModel)
                .environmentObject(router)
            SecondScreen()
                .tabItem {
                    Text("Second")
                    Image(systemName: "2.circle")
                }
                .tag(TabType.second.rawValue)
                .environmentObject(suffixViewModel)
            ThirdScreen()
                .tabItem {
                    Text("Third")
                    Image(systemName: "3.circle")
                }
                .tag(TabType.third.rawValue)
                .environmentObject(suffixViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
