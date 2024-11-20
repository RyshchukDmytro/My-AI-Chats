//
//  ChatManagerViewModel.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import Foundation

class ChatManagerViewModel: ObservableObject {
    @Published var chats: [Chat] = [
        Chat(id: UUID(), title: "Викладач американської англійської", role: "You are an experienced American English teacher who explains grammar and vocabulary clearly...", isCustom: false),
        Chat(id: UUID(), title: "Психотерапевт", role: "You are a compassionate psychotherapist who provides emotional support and advice...", isCustom: false),
        Chat(id: UUID(), title: "Помічник у програмуванні", role: "You are a skilled software developer who explains coding concepts...", isCustom: false),
        Chat(id: UUID(), title: "Майстер-шеф", role: "You are a professional chef who suggests recipes based on available ingredients...", isCustom: false),
        Chat(id: UUID(), title: "Щоденні цікаві факти", role: "You share interesting facts in a concise and engaging way.", isCustom: false)
    ]
    
    @Published var selectedChat: Chat?
    @Published var inputText: String = ""
    @Published var responseText: String = "Відповідь з'явиться тут."

    private let aiService = RoleBasedAIService()

    func sendMessage() {
        guard let selectedChat = selectedChat, !inputText.isEmpty else { return }

        // Визначення мови введення
        let detectedLanguagePrompt = "The user speaks in this language: \(inputText)\nPlease reply in the same language."

        let fullPrompt = "\(selectedChat.role)\n\n\(detectedLanguagePrompt)\nUser: \(inputText)\nAI:"
        aiService.getResponse(for: fullPrompt, role: "", completion: { [weak self] response in
            DispatchQueue.main.async {
                self?.responseText = response ?? "Помилка створення відповіді."
            }
        })

        inputText = ""
    }

    func addCustomChat(title: String, role: String) {
        let newChat = Chat(id: UUID(), title: title, role: role, isCustom: true)
        chats.append(newChat)
    }
}
