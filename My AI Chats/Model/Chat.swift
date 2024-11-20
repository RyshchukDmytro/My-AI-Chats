//
//  Chat.swift
//  My AI Chats
//
//  Created by Dmytro Ryshchuk on 11/19/24.
//

import Foundation

import Foundation

struct Chat: Identifiable {
    let id: UUID
    let title: String
    let role: String
    let isCustom: Bool
}
