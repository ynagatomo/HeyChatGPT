//
//  HistoryView.swift
//  heychatgpt
//
//  Created by Yasuhito Nagatomo on 2023/02/19.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) private var dismiss
    let talkLogs: [Conversation.Dialog]

    var body: some View {
        ZStack {
            Color("HomeBGColor").opacity(0.8)

            VStack {
                HStack {
                    Spacer()
                    Text("Dialog logs").font(.title2).foregroundColor(.white)
                    Spacer()
                    Button(action: dismiss.callAsFunction) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 40))
                    }
                }
                ScrollView {
//                    ForEach(conversation.talkLogs) { log in
                    ForEach(talkLogs) { log in
                        HStack {
                            Spacer()
                            Text(log.question)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.gray.cornerRadius(10))
                                .padding(.vertical, 4)
                            Image(systemName: "person.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.purple)
                        }
                        HStack {
                            Image(systemName: "server.rack")
                                .font(.system(size: 40))
                                .foregroundColor(.green)
                            Text(log.answer)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white.cornerRadius(10))
                                .padding(.vertical, 4)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static let talkLogs: [Conversation.Dialog] = [
        Conversation.Dialog(question: "My first question.", answer: "AI's answer."),
        Conversation.Dialog(question: "My 2nd question.", answer: "AI's answer.")
    ]
    static var previews: some View {
        HistoryView(talkLogs: talkLogs)
    }
}
