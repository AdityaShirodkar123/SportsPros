//
//  MessageBubble.swift
//  ChatApp
//
//  Created by Stephanie Diep on 2022-01-11.
//

import SwiftUI
import FirebaseAuth

struct MessageBubble: View {
    var message: Message
    @State private var messageText = ""
    @State private var isHidden = false
    @State private var isReported = false
    @State private var showTime = false
    @ObservedObject private var userViewModel = UserViewModel()
    private let user = Auth.auth().currentUser
    @ObservedObject private var messageViewModel = MessagesManager()
    
    func getReceived() -> Bool {
        print("at least onnnnce")
        if message.email == user?.email {
            print("it worked --> \(message.email) --> \(user!.email)")
            return false
        } else {
            print("it not worked --> \(message.name) --> \(userViewModel.mainUser.name)")
            return true
        }
    }
    
    var body: some View {
        let received = getReceived()
        
        VStack(alignment: received ? .leading : .trailing) {
            HStack {
                Text(message.name)
                if (received == false) {
                    Button(action: {
                        messageViewModel.blockedNames.append(message.name)
                        userViewModel.reportUser(name: message.name)
                        isReported = true
                        if isReported {
                            messageText = "[Report Sent to Us!]"
                        } else {
                            messageText = message.text
                        }
                    }, label: {Text("Report")})
                    Button(action: {
                        if (isReported == false) {
                            isHidden.toggle()
                            if isHidden {
                                messageText = "[Hidden]"
                            } else {
                                messageText = message.text
                            }
                        }
                    }, label: {Text("Hide")})
                }
            }
            HStack {
                Text(messageText)
                    .padding()
                    .background(received ? Color.gray : Color.blue)
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: received ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }.onAppear(perform: {messageText = message.text})
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(received ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: received ? .leading : .trailing)
        .padding(received ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "12345", text: "I've been coding applications from scratch in SwiftUI and it's so much fun!", email: "parekh.samarth@gmail.com", name: "Samarth", timestamp: Date(), articleID: 0))
    }
}
