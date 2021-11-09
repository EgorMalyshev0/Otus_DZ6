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
    @State var isLoading: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Enter your text:")
                TextEditor(text: $text)
                    .border(.gray, width: 1)
                    .padding()
                    .frame(maxHeight: 300)
                Button("Perform suffix magic", action: performAction)
                if isLoading {
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
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func performAction() {
        isLoading = true
        DispatchQueue.global().async {
            let startTime = Date()
            print("Starting work with text. Text count: \(text.count)\n")
            let set = CharacterSet(charactersIn: ".,:!?-()[]{}/\" ")
            let words = text.components(separatedBy: set)
            let seqs = words.map{WordSequence(word: $0)}
            var arr: [String] = []
            for s in seqs {
                arr.append(contentsOf: s.map{$0})
            }
            print("Suffix count: \(arr.count)\n")
            let dictionary = Dictionary(grouping: arr, by: {$0})
            print("\nGrouped suffix count: \(dictionary.count)\n")
            print("Terminating time: \(Date().timeIntervalSince(startTime)) s")
            DispatchQueue.main.async {
                suffixViewModel.suffixes = dictionary.map{SuffixItem(name: $0.key, count: $0.value.count)}
                isLoading = false
                router.selection = 1
            }
        }
    }
}

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen()
    }
}
