//
//  ChatView.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatManagerViewModel
    let chatTitle: String

    var body: some View {
        VStack {
            Text("Chat: \(chatTitle)")
                .font(.headline)
                .padding()

            ScrollView {
                Text(viewModel.responseText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            .padding()

            HStack {
                TextField("Enter your text...", text: $viewModel.inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Send") {
                    viewModel.sendMessage()
                }
                .padding()
            }
        }
    }
}
