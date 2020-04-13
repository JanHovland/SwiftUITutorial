//
//  ContentView.swift
//  SwiftUITutorial
//
//  Created by Jan Hovland on 13/04/2020.
//  Copyright © 2020 Jan Hovland. All rights reserved.
//

import SwiftUI
import WebKit
import CloudKit

var tutorials = [ Tutorial(title: "Getting Started With Combine",
                           introduction: "Maybe you’re not yet ready to jump\ninto SwiftUI but you can still get started\nwith Combine. Here’s a gentle introduction to using\nCombine to validate user input.",
                           url: "https://useyourloaf.com/blog/getting-started-with-combine/?utm_campaign=AppCoda%20Weekly&utm_medium=email&utm_source=Revue%20newsletter"),
                  Tutorial(title: "SwiftUI ButtonStyle",
                           introduction: "SwiftUI makes it very easy to customize\na button style. Learn how to create a reusable\nbutton style in SwiftUI.",
                           url:"https://sarunw.com/posts/swiftui-buttonstyle/?utm_campaign=AppCoda%20Weekly&utm_medium=email&utm_source=Revue%20newsletter")]

struct SafariView : NSViewRepresentable {
    var tutorial: Tutorial

    func updateNSView(_ nsView: WKWebView, context: Context) {
        
    }
    
    func makeNSView(context: Context) -> WKWebView  {
        let view = WKWebView()
        if let url = URL(string: tutorial.url) {
            view.load(URLRequest(url: url))
        }
        return view
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List (tutorials) { tutorial in
                NavigationLink(destination: SafariView(tutorial: tutorial)) {
                    MainView(tutorial: tutorial)
                }
            }
        }
        .listStyle(SidebarListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MainView: View {
    var tutorial: Tutorial
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text(tutorial.title)
                .font(Font.system(.headline))
            Text(tutorial.introduction)
                .padding(.leading, 15)
        }
        .padding(.top, 5)
    }
}
