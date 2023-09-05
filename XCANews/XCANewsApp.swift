//
//  XCANewsApp.swift
//  XCANews
//
//  Created by Alfian Losari on 6/27/21.
//

import SwiftUI
import Firebase

@main
struct XCANewsApp: App {
    
    //@StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                //.environmentObject(articleBookmarkVM)
        }
    }
}
