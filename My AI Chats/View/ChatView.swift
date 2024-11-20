//
//  ChatView.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import SwiftUI

struct ChatListView: View {
    @StateObject var viewModel = ChatViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.chats) { chat in
                NavigationLink(destination: ChatDetailView(viewModel: viewModel, chat: chat)) {
                    Text(chat.title)
                }
            }
            .navigationTitle("Available Chats")
        }
    }
}
