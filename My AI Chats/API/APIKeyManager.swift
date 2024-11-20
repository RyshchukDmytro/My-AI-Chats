//
//  APIKeyManager.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import Foundation

class APIKeyManager {
    static let shared = APIKeyManager()

    private init() {}

    var openAIKey: String? {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) else { return nil }
        return dict["OpenAIAPIKey"] as? String
    }
}
