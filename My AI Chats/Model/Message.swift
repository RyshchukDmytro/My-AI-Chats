//
//  Message.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let role: String
    let content: String
}
