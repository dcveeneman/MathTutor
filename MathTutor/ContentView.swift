//
//  ContentView.swift
//  MathTutor
//
//  Created by David Veeneman on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var firstNumber = 0
    @State private var secondNumber = 0
    @State private var firstNumberEmojis = ""
    @State private var secondNumberEmojis = ""
    private let emojis = ["🍕", "🍎", "🍏", "🐵", "👽", "🧠", "🧜🏽‍♀️", "🧙🏿‍♂️", "🥷", "🐶", "🐹", "🐣", "🦄", "🐝", "🦉", "🦋", "🦖", "🐙", "🦞", "🐟", "🦔", "🐲", "🌻", "🌍", "🌈", "🍔", "🌮", "🍦", "🍩", "🍪"]
    var body: some View {
        VStack {
            Group {
                Text(firstNumberEmojis)
                Text("+")
                Text(secondNumberEmojis)
            }
            .font(.system(size: 80))
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            Spacer()
            
            Text("\(firstNumber) + \(secondNumber)")
                .font(.largeTitle)
            
            Spacer()
        }
        .padding()
        .onAppear {
            firstNumber = Int.random(in:1...10)
            secondNumber = Int.random(in:1...10)
            firstNumberEmojis = setupEmojiString(number: firstNumber)
            secondNumberEmojis = setupEmojiString(number: secondNumber)
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
}

#Preview {
    ContentView()
}
