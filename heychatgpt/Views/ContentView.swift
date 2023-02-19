//
//  ContentView.swift
//  heychatgpt
//
//  Created by Yasuhito Nagatomo on 2023/02/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject var conversation = Conversation()
    @State private var showHistory = false
    private var canSpeak: Bool {
        (conversation.state == .idle) && !conversation.answer.isEmpty
    }
    private var canStartConversation: Bool { conversation.state == .idle }
    private var canStopConversation: Bool { conversation.state == .listening }
    private var canAsk: Bool { conversation.state != .asking }

    var body: some View {
        ZStack {
            Color("HomeBGColor")

            VStack {
                HStack {
                    Spacer()
                    Text("Talk with ChatGPT!").font(.title2)
                    Spacer()
                    Button(action: { showHistory.toggle() }, label: {
                        Image(systemName: "list.bullet.rectangle")
                            .font(.system(size: 32))
                            .foregroundColor(.blue)
                    })
                }

                // Message area
                ScrollView(showsIndicators: false) {

                    // Human' question
                    HStack {
                        Spacer()
                        Text(conversation.question)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.cornerRadius(10))
                            .padding(.vertical, 4)
                        Image(systemName: "person.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.purple)
                    }

                    // Answer from AI
                    HStack {
                        // Button to speak or to stop speaking
                        Button(action: speak) {
                            VStack {
                                Image(systemName: "speaker.wave.2.bubble.left.fill")
                                    .font(.system(size: 40))
                                Image(systemName: "server.rack")
                                    .font(.system(size: 40))
                            }.foregroundColor(canSpeak ? .green : .gray)
                        }
                        .disabled(!canSpeak)

                        Text(conversation.answer)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.cornerRadius(10))
                            .padding(.vertical, 4)
                        Spacer()
                    }
                }

                Spacer()

                // Prompt area
                if conversation.state != .listening {
                    // Button to start a conversation (Voice recognition will start.)
                    Button(action: startListening) {
                        HStack {
                            Image(systemName: "mic.fill")
                                .font(.system(size: 40))
                                .frame(width: 60, height: 60)
                                .background(canStartConversation ? Color.blue : Color.gray)
                                .clipShape(Circle())
                            Text("Start conversation")
                                .padding(.leading, 8)
                        }
                    }
                    .disabled(!canStartConversation)
                } else {
                    HStack {
                        // Button to stop the conversation (Voice recognition will stop.)
                        Button(action: stopListening) {
                            Image(systemName: "stop.fill")
                                .font(.system(size: 32))
                                .frame(width: 60, height: 60)
                                .background(Color.gray)
                                .clipShape(Circle())
                        }
                        .disabled(!canStopConversation)

                        // A prompt recognized from human's voice
                        Text(conversation.prompt)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.cornerRadius(10))
                            .padding(.horizontal, 8)

                        Spacer()

                        // Button to ask ChatGPT about the prompt
                        Button(action: ask) {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 32))
                                .frame(width: 60, height: 60)
                                .background(canAsk ? Color.blue : Color.gray)
                                .clipShape(Circle())
                        }
                        .disabled(!canAsk)
                    }
                }
            }
            .padding()
            .onAppear {
                // Request an authorization for voice recognition
                SpeechRecognizer.shared.requestAuthorization()
            } // VStack
        } // ZStack
        .foregroundColor(.white)
        .sheet(isPresented: $showHistory) {
            HistoryView(conversation: conversation)
        }
    }

    // Speak the answer from ChatGPT or stop speaking when speaking
    private func speak() {
        conversation.speak()
    }

    // Ask ChatGPT about the prompt(question)
    private func ask() {
        Task {
            await conversation.ask()
        }
    }

    // Start listening (will start voice recognition)
    private func startListening() {
        conversation.startListening()
    }

    // Stop listening (will stop voice recognition)
    private func stopListening() {
        conversation.stopListening()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
