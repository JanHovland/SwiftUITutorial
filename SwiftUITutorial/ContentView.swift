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
                           introduction: "Maybe you’re not yet ready to jump\ninto SwiftUI but you can still get started\nwith Combine. Here’s a gentle introduction to using \nCombine to validate user input.",
                           url: "https://useyourloaf.com/blog/getting-started-with-combine/?utm_campaign=AppCoda%20Weekly&utm_medium=email&utm_source=Revue%20newsletter"),
                  Tutorial(title: "SwiftUI ButtonStyle",
                           introduction: "SwiftUI makes it very easy to customize\n a button style. Learn how to create a reusable\n button style in SwiftUI.",
                           url:"https://sarunw.com/posts/swiftui-buttonstyle/?utm_campaign=AppCoda%20Weekly&utm_medium=email&utm_source=Revue%20newsletter")]

struct TestView : NSViewRepresentable {
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
    }
    
    var tutorial: Tutorial
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
                NavigationLink(destination: TestView(tutorial: tutorial)) {
                    VStack (alignment: .trailing) {
                        VStack (alignment: .center) {
                            Text(tutorial.title)
                            Text(tutorial.introduction)
                        }
                    }
                }
            }
        }
        .listStyle(SidebarListStyle())
        /// .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(1 ... 10, id: \.self) { index in
//                    NavigationLink(destination: DetailView(value: index)) {
//                        Text("Link \(index)")
//                    }
//                }
//
//            }
//        }
//        .listStyle(SidebarListStyle())
//    }
//}
//
//
//struct DetailView: View {
//    var value: Int
//
//    var body: some View {
//        Text("Detail Link for index " + String(value))
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//}
