//
//  LoginView.swift
//  hebrew
//
//  Created by Aditya Shirodkar on 7/25/22.
//

import SwiftUI
import FirebaseStorage
import CryptoKit
import FirebaseAuth
import AuthenticationServices

struct Login: View {
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @State var loginError = ""
    @State var signUpError = ""
    @State var visible = false

    @ObservedObject var viewModel = UserViewModel()
    @ObservedObject var sessionSession = SessionStore()
    
    @State var signedUp = false
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    @State var color = Color.black.opacity(0.7)
    @State var userNOTEXIST = false
    
    
    @State var currentNonce:String?
       
       //Hashing function using CryptoKit
       func sha256(_ input: String) -> String {
           let inputData = Data(input.utf8)
           let hashedData = SHA256.hash(data: inputData)
           let hashString = hashedData.compactMap {
           return String(format: "%02x", $0)
           }.joined()

           return hashString
       }
    
    // from https://firebase.google.com/docs/auth/ios/apple
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    @ViewBuilder
    private var signIN: some View {
        VStack {
            Text("Sign in to your account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            TextField("Email",text:self.$email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius:6).stroke(borderColor, lineWidth:2))
                .padding(.top, 0)
            
            HStack(spacing: 15){
                VStack{
                    if self.visible {
                        TextField("Password", text: self.$password)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Password", text: self.$password)
                            .autocapitalization(.none)
                    }
                }
                
                Button(action: {
                    self.visible.toggle()
                }) {
                    //Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(self.color)
                        .opacity(0.8)
                }
            }.padding()
                .background(RoundedRectangle(cornerRadius: 6)
                .stroke(borderColor,lineWidth: 2))
                .padding(.top, 10)
            
            Button("Log in", action: {
                sessionSession.signIn(email: email, password: password)
            })
            
            
            Text(loginError).foregroundColor(.red)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ViewBuilder
    private var register: some View {
        VStack {
            Text("Create an Account")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            TextField("Name",text: self.$name)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius:6).stroke(borderColor, lineWidth:2))
                .padding(.top, 0)
            
            TextField("Email",text: self.$email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius:6).stroke(borderColor, lineWidth:2))
                .padding(.top, 0)
            
            HStack(spacing: 15){
                VStack{
                    if self.visible {
                        TextField("Password", text: self.$password)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Password", text: self.$password)
                            .autocapitalization(.none)
                    }
                }
                
                Button(action: {
                    self.visible.toggle()
                }) {
                    //Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(self.color)
                        .opacity(0.8)
                }
            }.padding()
                .background(RoundedRectangle(cornerRadius: 6)
                .stroke(borderColor,lineWidth: 2))
                .padding(.top, 10)
            
            
            Button("Sign up", action: {
                if (name != "" && email != "" && password != "") {
                    sessionSession.signUp(email: email, password: password)
                    viewModel.createUser(name: name, email: email, handler: {_ = true})
                    if sessionSession.isAnon {
                        signUpError = "Error Creating Account"
                    }
                }
            }).padding(10.0)
            
            Text(signUpError).foregroundColor(.red)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                signIN.navigationViewStyle(StackNavigationViewStyle())
                
                NavigationLink(destination: register) {
                    Text("Sign up")
                }.navigationViewStyle(StackNavigationViewStyle())
            }
            .padding(.horizontal)
            .navigationBarTitle("").navigationBarHidden(true).navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
