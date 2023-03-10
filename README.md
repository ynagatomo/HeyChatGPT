# iOS app - Hey ChatGPT

![AppIcon](assets/appIcon180.png)

A minimal iOS app that interacts with ChatGPT. You can use your voice to ask questions and listen to ChatGPT's responses.

- Target devices: iPhone / iPad / Mac with M1/M2 (Designed for iPad)
- Target OS: iOS 16.0+, iPadOS 16.0+, macOS 13.0+
- Build system: Xcode 14.3+
- SDK: SwiftUI, AVFoundation, Speech
- Swift Packages: OpenAISwift (OpenAI API Client Library in Swift)

You can probably use Xcode 14.0+. However, it has not been tested.

## Change Log

none

## Abstract

This is a minimal iOS app that communicates with ChatGPT using OpenAI API.
The purpose of this project is showing a very basic sample code which uses the OpenAISwift Library.
The library abstracts and simplifies communication with OpenAI servers using the OpenAI API.

Users can receive answers to their questions from the OpenAI server.
Using the iOS SDK's speech recognition and text-to-speech, users can speak their questions and listen to the answers.

In order to use the OpenAI API, you need to sign up to the service and get the API key.
First you are given free credits. When it is used up, it is necessary to subscribe to a paid service.

### Features

- Users can input questions by voice.
- Users can get answers for the questions from ChatGPT, OpenAI's language AI.
- Users can listen answers by voice.
- Users can see their interaction history.

* Language: This project supports English (en-US) for voice-recognition and speech synthesis.
You can switch to other language modifying the code.

* OpenAI LLM: This project uses the text-davinci-003 GPT-3 model by default.
You can switch to other models such as text-curie-001, text-babbage-001, or text-ada-001 (fastest one), modifying the code.

### Usage

1. Ask questions by voice.
1. Send the questions to OpenAI ChatGPT.
1. View or hear the answers from OpenAI ChatGPT.

![Image](assets/ui_1600.png)
<!-- ![GIF](assets/movie.gif) -->

## Preparation to build and run the project

### Import the OpenAISwift Library

Import the adamrushy/OpenAISwift Swift Package to the project. URL: https://github.com/adamrushy/OpenAISwift

### Get the OpenAI API Key

The API Key for OpenAI API is required.
You need to sign up to OpenAI site (https://openai.com/api/) and get the key.
You can get the key at the account management page. (https://platform.openai.com/account/)

### Add the API key file to the project

Add `APIKey.swift` file to the project and define the key you got as below.

```swift
// APIKey.swift
enum OpenAIAPIKey {
    static let key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

### Check your credits

To use the OpenAI API, you need credits. You will get some free credits when you sign up.
After using it, you need to purchase a paid subscription.
It is reasonable because the computational cost of LLM is very high.

If there are no valid credits, the OpenAISwift API will return error 1.: 
`The operation could't be completed. (OpenAISwift.OpenAIError error 1)`

## Considerations

### Large Language Models

The project uses the GPT-3 LLM, text-davinci-003, by default.
You can switch to another model specifying the model when calling the OpenAISwift API;

`func sendCompletion(with prompt: String, model: OpenAIModelType = .gpt3(.davinci), maxTokens: Int = 16) async throws -> OpenAI`

![Image](assets/models_1280.jpeg)
(c)OpenAI (https://platform.openai.com/docs/models/)

### Supported Language for voice recognition and speech synthesis

The project supports English (en-US) by default.
You can switch to other ones to specify it when calling APIs.

- `SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!`
- `AVSpeechSynthesisVoice(language: "en-US") // BCP47 language code`

## Design

### Type Structure and State Machines

The app consists of simple SwiftUI Views, a View Model, Managers.

![Image](assets/types_1280.png)


## References

- API: OpenAI API: https://openai.com/api/
- Library: adamrushy/OpenAISwift Swift Package: https://github.com/adamrushy/OpenAISwift
- Article: Moritz Philip Reche, Feb 14, 2023, Creating a SwiftUI App to interact with the OpenAI ChatGPT API, https://www.createwithswift.com/building-a-swiftui-app-to-interact-with-the-openai-chatgpt-api/
- Apple Sample Code: Recognizing Speech in Live Audio, https://developer.apple.com/documentation/speech/recognizing_speech_in_live_audio
- Apple Documentation: AVFoundation / Speech Synthesis, https://developer.apple.com/documentation/avfoundation/speech_synthesis
- Apple Documentation: Speech, https://developer.apple.com/documentation/speech

## License

![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)
