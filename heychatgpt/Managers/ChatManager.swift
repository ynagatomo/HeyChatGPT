//
//  ChatManager.swift
//  heychatgpt
//
//  Created by Yasuhito Nagatomo on 2023/02/18.
//

import OpenAISwift

final class ChatManager {
    static let shared = ChatManager()

    private let openAIServices: OpenAISwift = OpenAISwift(authToken: OpenAIAPIKey.key)
    private init() {}

    func sendText(_ text: String) async -> String {
        var response = ""
        do {
            let result = try await openAIServices.sendCompletion(with: text, maxTokens: 300)
            response = result.choices.first?.text ?? "oops"
        } catch {
            response = error.localizedDescription
        }
        return response
    }
}
