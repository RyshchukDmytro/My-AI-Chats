//
//  OpenAIResponse.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import Foundation

struct OpenAIResponse: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
    let system_fingerprint: String

    struct Choice: Decodable {
        let index: Int
        let message: Message
        let logprobs: String?
        let finish_reason: String?

        struct Message: Decodable {
            let role: String
            let content: String
            let refusal: String?
        }
    }

    struct Usage: Decodable {
        let prompt_tokens: Int
        let completion_tokens: Int
        let total_tokens: Int
        let prompt_tokens_details: TokenDetails
        let completion_tokens_details: TokenDetails

        struct TokenDetails: Decodable {
            let cached_tokens: Int?
            let audio_tokens: Int?
            let reasoning_tokens: Int?
            let accepted_prediction_tokens: Int?
            let rejected_prediction_tokens: Int?
        }
    }
}

