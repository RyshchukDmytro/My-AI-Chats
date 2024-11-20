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
        guard let url = URL(string: "https://api.openai.com/v1/completions") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": input,
            "max_tokens": 200,
            "temperature": 0.7
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else { return }
            if let response = try? JSONDecoder().decode(OpenAIResponse.self, from: data) {
                completion(response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines))
            }
        }.resume()
    }
}

struct OpenAIResponse: Decodable {
    let choices: [Choice]

    struct Choice: Decodable {
        let text: String
    }
}
