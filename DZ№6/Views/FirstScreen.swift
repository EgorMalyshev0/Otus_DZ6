//
//  FirstScreen.swift
//  DZ№6
//
//  Created by Egor Malyshev on 04.11.2021.
//

import SwiftUI

struct FirstScreen: View {
    
    @EnvironmentObject var router: Router
    @EnvironmentObject var suffixViewModel: SuffixViewModel
    
    @State private var text = "Example text"

    let publisher = NotificationCenter.default.publisher(for: NSNotification.suffixSearchFinished.name)

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Enter your text:")
                TextEditor(text: $text)
                    .border(.gray, width: 1)
                    .padding()
                    .frame(maxHeight: 300)
                Button("Perform suffix magic") {
                    suffixViewModel.performSearch(with: text)
                }
                if suffixViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
        }
        .navigationBarHidden(true)
        .onTapGesture {
            hideKeyboard()
        }
        .onReceive(publisher) { _ in
            router.selection = 2
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
