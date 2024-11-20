//
//  ChatDetailView.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import SwiftUI

struct ChatDetailView: View {
    @ObservedObject var viewModel: ChatViewModel
    let chat: Chat
    @State private var inputText: String = ""

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.messages) { message in
                        HStack {
                            if message.role == "user" {
                                Spacer()
                                Text(message.content)
                                    .padding()
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(.blue)
                            } else {
                                Text(message.content)
                                    .padding()
                                    .background(Color.green.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(.green)
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding()

            HStack {
                TextField("Type your message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Send") {
                    viewModel.sendMessage(input: inputText)
                    inputText = ""
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.setCurrentChat(chat)
        }
        .navigationTitle(chat.title)
    }
}
