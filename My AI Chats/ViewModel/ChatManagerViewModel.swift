//
//  ChatManagerViewModel.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var chats: [Chat] = [
        Chat(title: "American English Teacher", role: "You are a helpful assistant specializing in teaching American English."),
        Chat(title: "Mental Health Support", role: "You are a compassionate mental health assistant."),
        Chat(title: "Programming Buddy", role: "You are an expert programmer ready to help with coding questions."),
        Chat(title: "Master Chef", role: "You are a master chef providing recipe recommendations."),
        Chat(title: "Daily Fun Facts", role: "You provide interesting daily facts.")
    ]
    @Published var currentChat: Chat? = nil
    @Published var messages: [Message] = []

    private let aiService = RoleBasedAIService()

    func setCurrentChat(_ chat: Chat) {
        currentChat = chat
        messages = []
    }

    func sendMessage(input: String) {
        guard let currentChat = currentChat else { return }

        messages.append(Message(role: "user", content: input))

        aiService.getResponse(for: input, role: currentChat.role) { [weak self] response in
            DispatchQueue.main.async {
                if let response = response {
                    self?.messages.append(Message(role: "assistant", content: response))
                }
            }
        }
    }
}
