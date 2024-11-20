//
//  RoleBasedAIService.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import Foundation

class RoleBasedAIService {
    private let apiKey = APIKeyManager.shared.openAIKey ?? ""

    func getResponse(for input: String, role: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "system", "content": role],
                ["role": "user", "content": input]
            ],
            "max_tokens": 100,
            "temperature": 0.7
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received.")
                completion(nil)
                return
            }

            #if DEBUG
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON: \(jsonString)")
            }
            #endif

            if let response = try? JSONDecoder().decode(OpenAIResponse.self, from: data) {
                completion(response.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines))
            } else {
                completion(nil)
            }
        }.resume()
    }
}
