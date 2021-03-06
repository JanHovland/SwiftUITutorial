//
//  ContentView.swift
//  SwiftUITutorial
//
//  Created by Jan Hovland on 13/04/2020.
//  Copyright © 2020 Jan Hovland. All rights reserved.
//

//  Block comment : Ctrl + Cmd + / (on number pad)
//  Indent        : Ctrl + Cmd + * (on number pad)

import SwiftUI
import CloudKit

struct SwiftUITutorial: View {
    
    /// Dersom du legger inn nye AppIcon, reset Xcode, kjør CleanMyMacX og kompiler på nytt
    
    @State private var tutorials =
        [Tutorial(title: "Getting Started With Combine",
             introduction: "Maybe you’re not yet ready to jump into SwiftUI but you can still get started with Combine. Here’s a gentle introduction to using Combine to validate user input.",
             url: "https://useyourloaf.com/blog/getting-started-with-combine/?utm_campaign=AppCoda%20Weekly&utm_medium=email&utm_source=Revue%20newsletter"),
         Tutorial(title: "SwiftUI ButtonStyle",
             introduction: "SwiftUI makes it very easy to customize a button style. Learn how to create a reusable button style in SwiftUI.",
             url:"https://sarunw.com/posts/swiftui-buttonstyle/?utm_campaign=AppCoda%20Weekly&utm_medium=email&utm_source=Revue%20newsletter")
         ]
   
    @State private var alertIdentifier: AlertID?
    @State private var message: String = ""
    @State private var message1: String = ""

    var body: some View {
        NavigationView {
            List (tutorials) { tutorial in
                NavigationLink(destination: SafariView(url: tutorial.url)) {
                    MasterView(tutorial: tutorial)
                }
            }
        }
        .listStyle(SidebarListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.refresh()
        }
        .alert(item: $alertIdentifier) { alert in
            switch alert.id {
            case .first:
                return Alert(title: Text(self.message), message: Text(self.message1), dismissButton: .cancel())
            case .second:
                return Alert(title: Text(self.message), message: Text(self.message1), dismissButton: .cancel())
            case .third:
                return Alert(title: Text(self.message), message: Text(self.message1), dismissButton: .cancel())
            }
        }
    }
    
    /// Rutine for å friske opp bildet
    func refresh() {
        /// Sletter alt tidligere innhold i person
        tutorials.removeAll()
        /// Fetch all tutorials from CloudKit
        let predicate = NSPredicate(value: true)
        CloudKitTutorial.fetchTutorial(predicate: predicate)  { (result) in
            switch result {
            case .success(let tutorial):
                self.tutorials.append(tutorial)
                self.tutorials.sort(by: {$0.title < $1.title})
                self.message = NSLocalizedString("Fetched all Tutorial data", comment: "SwiftUITutorial")
                self.message1 = NSLocalizedString("Now all the data is extracted from the Tutorial table on CloudKit", comment: "SwiftUITutorial")
                self.alertIdentifier = AlertID(id: .first)
            case .failure(let err):
                self.message = err.localizedDescription
                self.alertIdentifier = AlertID(id: .first)
            }
        }
    }

}

struct MasterView: View {
    var tutorial: Tutorial
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text(tutorial.title)
                .font(.system(size: 15, weight: .light, design: .rounded))
            Text(tutorial.introduction)
                .font(.system(size: 13, weight: .ultraLight))
                .padding(.leading, 15)
                /// .frame gjør at en lang tekst spittes opp i flere linjer uten at enmå legge inn \n
                .frame(width: 250)
        }
        .padding(.top, 5)
    }
}
