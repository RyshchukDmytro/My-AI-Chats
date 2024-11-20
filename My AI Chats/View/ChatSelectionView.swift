//
//  ChatSelectionView.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import SwiftUI

struct ChatSelectionView: View {
    @StateObject private var viewModel = ChatManagerViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.chats) { chat in
                        Button(action: {
                            viewModel.selectedChat = chat
                        }) {
                            Text(chat.title)
                        }
                    }
                }
                .navigationTitle("Select a chat")
                .toolbar {
                    Button(action: {
                        viewModel.addCustomChat(title: "New chat", role: "You are a general assistant ready to answer any question.")
                    }) {
                        Label("Add a chat", systemImage: "plus")
                    }
                }

                if let selectedChat = viewModel.selectedChat {
                    ChatView(viewModel: viewModel, chatTitle: selectedChat.title)
                } else {
                    Text("Select chat from the list")
                        .font(.headline)
                        .padding()
                }
            }
        }
    }
}
