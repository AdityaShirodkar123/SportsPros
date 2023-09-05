//
//  ContentView.swift
//  XCANews
//
//  Created by Alfian Losari on 6/27/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var articleBookmarkVM2 =  ArticleBookmarkViewModel()
    @State private var notReadEULA = true
    private var EULAText = ["Chatrooms should not include any foul language or abusive content. If this content is found or reported, your account will be terminated.", "Report and block features are provided by tapping on the profile of each user. If the report feature is abused by a user, their account will be terminated. Reports are reviewed at least once every 6 hours.", "You may enter and talk in chatrooms at your own risk.", "We monitor chatrooms at least once every 6 hours and contain basic filters to avoid foul language or slurs.", "We do not endorse any discussion or comments made in any of these chatrooms."]
    
    @ViewBuilder
    private var ActualContent: some View {
        TabView {
            NewsTabView().navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            SearchTabView().navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            BookmarkTabView().navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }.onTapGesture {
                    articleBookmarkVM2.loadSaved()
                }
            
            AppSubmissionView().navigationViewStyle(StackNavigationViewStyle()).tabItem {
                Label("Apply", systemImage: "newspaper")
            }
            
            /*Text("Email SportsPros0714@gmail.com to submit your own article!").tabItem {
                Label("Apply", systemImage: "newspaper")
            }*/
            /*SafariView(url: URL(string: "https://forms.gle/e7sPbQokkSBG4NLZ9")!).tabItem {
                Label("Apply", systemImage: "newspaper")
            }*/
        }
    }
    
    @ViewBuilder
    private var AppStartView: some View {
        Text("EULA FOR CHATROOMS").font(.title)
        
        ForEach(EULAText, id: \.self) { paragraph in
            Text(paragraph).font(Font.custom("times new roman", size: 20, relativeTo: .subheadline)).padding(.vertical, 30)
        }
        
        Button(action: {self.notReadEULA = false}, label: {
            Text("I have read and accept this EULA.")
        })
    }
    
    var body: some View {
        ActualContent.fullScreenCover(isPresented: $notReadEULA, content: {AppStartView})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
