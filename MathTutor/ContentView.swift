//
//  ContentView.swift
//  MathTutor
//
//  Created by David Veeneman on 11/10/23.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @FocusState private var textFieldIsFocused: Bool
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var firstNumberEmojis = ""
    @State private var secondNumberEmojis = ""
    @State private var answer = ""
    @State private var audioPlayer: AVAudioPlayer!
    @State private var textFieldIsDisabled = false
    @State private var guessButtonDisabled = false
    @State private var message = ""
    private let emojis = ["🍕", "🍎", "🍏", "🐵", "👽", "🧠", "🧜🏽‍♀️", "🧙🏿‍♂️", "🥷", "🐶", "🐹", "🐣", "🦄", "🐝", "🦉", "🦋", "🦖", "🐙", "🦞", "🐟", "🦔", "🐲", "🌻", "🌍", "🌈", "🍔", "🌮", "🍦", "🍩", "🍪"]
    var body: some View {
        VStack {
            Group {
                Text(firstNumberEmojis)
                    .font(.system(size: 80))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                Text("+")
                Text(secondNumberEmojis)
                    .font(.system(size: 80))
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Text("\(firstNumber) + \(secondNumber) =")
                .font(.largeTitle)
            
            TextField("", text: $answer)
                .font(.largeTitle)
                .fontWeight(.black)
                .textFieldStyle(.roundedBorder)
                .frame(width: 60)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 2.0)
                }
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .focused($textFieldIsFocused)
                .disabled(textFieldIsDisabled)
            
            Button("Guess") {
                textFieldIsFocused = false
                let result = firstNumber + secondNumber
                if let answerValue = Int(answer) {
                    if answerValue == result {
                        playSound(soundName: "correct")
                        message = "Correct!"
                    } else {
                        playSound(soundName: "wrong")
                        message = "Sorry, the correct answer is \(firstNumber + secondNumber)"
                    }
                } else {
                    playSound(soundName: "wrong")
                    message = "Sorry, the correct answer is \(firstNumber + secondNumber)"
                }
                textFieldIsDisabled = true
                guessButtonDisabled = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(answer.isEmpty || guessButtonDisabled)
            
            Spacer()
            
            Text(message)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .foregroundColor(message == "Correct!" ? .green : .red)
            
            if guessButtonDisabled {
                Button("Play Again?") {
                    guessButtonDisabled = false
                    answer = ""
                    textFieldIsDisabled = false
                    message = ""
                    generateNewEquation()
                }
                
            }
        }
        .padding()
        .onAppear {
            generateNewEquation()
        }
    }
    
    func setupEmojiString(number:Int)-> String {
        var emojiString = ""
        
        // Long version
        //        let randomEmoji = emojis.randomElement()!
        //        for _ in 1...number {
        //            emojiString += randomEmoji
        //        }
        
        //Short version
        emojiString = String(repeating: emojis.randomElement()!, count: number)
        
        return emojiString
    }
    
    func generateNewEquation() {
        firstNumber = Int.random(in:1...10)
        secondNumber = Int.random(in:1...10)
        firstNumberEmojis = setupEmojiString(number: firstNumber)
        secondNumberEmojis = setupEmojiString(number: secondNumber)
    }
    
    func playSound(soundName: String) {
        // Requires AVFAudio import, state variable for AVAudioPlayer

        guard let soundFile = NSDataAsset(name: soundName) else {
            print("􀀳 Could not read sound file named \(soundName)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("􀀳 ERROR: \(error.localizedDescription) playing audio player.")
        }

    }

}

#Preview {
    ContentView()
}
