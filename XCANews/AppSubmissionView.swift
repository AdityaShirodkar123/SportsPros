//
//  AppSubmissionView.swift
//  XCANews
//
//  Created by Aditya Shirodkar on 10/20/22.
//

import SwiftUI

struct AppSubmissionView: View {
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    @State private var name = ""
    @State private var desc = ""
    @State private var email = ""
    @State private var useLessButton = false
    
    var body: some View {
        VStack {
        Text("Submit Article for Review")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 15)
        
        Text("We will review the submission and send an email to follow up on the submission.")
            .font(.headline)
            .fontWeight(.bold)
            .padding(.top, 15)
        
        TextField("Title",text: self.$name)
            .autocapitalization(.none)
            .padding()
            .background(RoundedRectangle(cornerRadius:6).stroke(borderColor, lineWidth:2))
            .padding(.top, 0)
        
        TextField("Description",text: self.$desc)
            .autocapitalization(.none)
            .padding()
            .background(RoundedRectangle(cornerRadius:6).stroke(borderColor, lineWidth:2))
            .padding(.top, 0)
        
        TextField("Email",text: self.$email)
            .autocapitalization(.none)
            .padding()
            .background(RoundedRectangle(cornerRadius:6).stroke(borderColor, lineWidth:2))
            .padding(.top, 0)
        
        Button("Submit", action: {
            useLessButton.toggle()
        })
        }
        
    }
}

struct AppSubmissionView_Previews: PreviewProvider {
    static var previews: some View {
        AppSubmissionView()
    }
}
