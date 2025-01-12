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
            ScrollViewReader { proxy in
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
                            .id(message.id)
                        }
                    }
                }
                .padding()
                .onChange(of: viewModel.messages) {
                    scrollToBottom(proxy: proxy)
                }
                .gesture(
                    TapGesture()
                        .onEnded { hideKeyboard() }
                )
            }

            HStack {
                TextField("Type your message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onTapGesture {
                        hideKeyboard()
                    }

                Button("Send") {
                    if !inputText.isEmpty {
                        viewModel.sendMessage(input: inputText)
                        inputText = ""
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.setCurrentChat(chat)
        }
        .navigationTitle(chat.title)
    }

    private func scrollToBottom(proxy: ScrollViewProxy?) {
        if let lastMessageID = viewModel.messages.last?.id {
            withAnimation {
                proxy?.scrollTo(lastMessageID, anchor: .bottom)
            }
        }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
