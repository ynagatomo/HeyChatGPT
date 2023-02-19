//
//  Synthesizer.swift
//  heychatgpt
//
//  Created by Yasuhito Nagatomo on 2023/02/18.
//

import AVFoundation

final class Synthesizer {
    static let shared = Synthesizer()

    private let synthesizer = AVSpeechSynthesizer()
    private let voice = AVSpeechSynthesisVoice(language: "en-US") // BCP47 language code
    private init() {}

    var isSpeaking: Bool {
        synthesizer.isSpeaking
    }

    func speak(_ text: String) {
        guard !synthesizer.isSpeaking && !synthesizer.isPaused else { return }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice

        let avSession = AVAudioSession.sharedInstance()
        try? avSession.setCategory(AVAudioSession.Category.playback, options: .mixWithOthers)

        // [Note] Set below parameters if needed
        // utterance.pitchMultiplier = 1.0 // pitch: default: 1.0, less => low-pitched
        // utterance.volume = 1.0 // volume: default: 1.0, less => lower
        // utterance.rate = 0.5 // speed: 0.0...1.0, default: 0.5

        synthesizer.speak(utterance)
    }

    func stopSpeaking() {
        guard synthesizer.isSpeaking else { return }

        synthesizer.stopSpeaking(at: .immediate)
    }
}
