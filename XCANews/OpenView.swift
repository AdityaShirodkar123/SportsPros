//
//  OpenView.swift
//  hebrew
//
//  Created by Aditya Shirodkar on 8/2/22.
//

import SwiftUI

struct OpenView: View {
    
    
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var sessionStore = SessionStore()
    var articleID2 : Int

    
    init(articleID2 : Int) {
        self.articleID2 = articleID2
        sessionStore.signOut()
        sessionStore.listen()
    }
    
    var body: some View {
        if sessionStore.isAnon {
            Login().navigationViewStyle(StackNavigationViewStyle())
        } else {
            ContentView1(articleID: articleID2).navigationViewStyle(StackNavigationViewStyle())
        }
        /*ContentView1().fullScreenCover(isPresented: $sessionStore.isAnon, content: {
            Login()
        })*/
    }
}

struct OpenView_Previews: PreviewProvider {
    static var previews: some View {
        OpenView(articleID2: 0)
    }
}
