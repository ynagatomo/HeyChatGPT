//
//  Conversation.swift
//  heychatgpt
//
//  Created by Yasuhito Nagatomo on 2023/02/18.
//

import Foundation

@MainActor
final class Conversation: ObservableObject {
    struct Dialog: Identifiable {
        let id = UUID()
        let question: String
        let answer: String
    }
    enum State { case idle, listening, asking }
    static let initPrompt = "(listening...)"
    static let initAnswer = "(thinking...)"
    @Published var prompt = ""      // input text
    @Published var question = ""
    @Published var answer = ""
    @Published var talkLogs = [Dialog]()
    @Published var state: State = .idle

    func startListening() {
        Synthesizer.shared.stopSpeaking()
        state = .listening
        prompt = Self.initPrompt
        SpeechRecognizer.shared.startRecording(progressHandler: { text in
            self.prompt = text
        })
    }

    func stopListening() {
        state = .idle
        SpeechRecognizer.shared.stopRecording()
    }

    func ask() async {
        guard prompt != Self.initPrompt else { return }
        state = .asking
        SpeechRecognizer.shared.stopRecording()

        question = prompt
        answer = Self.initAnswer
        prompt = Self.initPrompt

        answer = await ChatManager.shared.sendText(question)
        talkLogs.append(Dialog(question: question, answer: answer))

        state = .idle
    }

    func speak() {
        guard answer != Self.initAnswer else { return }

        if Synthesizer.shared.isSpeaking {
            Synthesizer.shared.stopSpeaking()
        } else {
            Synthesizer.shared.speak(answer)
        }
    }
}
