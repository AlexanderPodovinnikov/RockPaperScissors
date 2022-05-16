//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alex Po on 14.05.2022.
//  ✊✋✌️

import SwiftUI

struct ContentView: View {
    let figures = ["✊", "✋", "✌️"]
    let winningCombinations = [1, 2, 0]
    
    @State private var userWin = Bool.random()
    @State private var appChoice = Int.random(in: 0..<3)
    @State private var score: Int = 0
    @State private var count = 0
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Score: \(score)")
                    .font(.headline)
                Text("My move: \(figures[appChoice])")
                    .font(.title)
                    .padding(.vertical)
                
                Text("You \(userWin ? "WIN" : "LOOSE")")
                    .font(.headline)
                    .padding(.vertical)
                Text("What is your move:")
                    .font(.title)
                HStack {
                    ForEach(0..<figures.count, id:\.self) { userChoice in
                        Button("\(figures[userChoice])") {
                            updateScore(figure: userChoice)
                        }
                    }
                }
                .font(.system(size: 80))
                .padding()
            }
            .navigationTitle("Play With Me")
            .padding()
            .alert("Game over", isPresented: $isShowingAlert) {
                Button("OK") {
                    startNewGame()
                }
            } message: {
                Text("Start new game?")
            }
        }
    }
    
    func winOrLoose(userMove: Int) -> Bool? {
        if  appChoice == userMove {
            return nil
        } else if userMove == winningCombinations[appChoice] {
            return true
        }
        return false
    }
    
    func updateScore(figure: Int) {
        if let winOrLoose = winOrLoose(userMove: figure) {
            if userWin == winOrLoose {
                score += 1
            } else {
                score -= 1
            }
        }
        count += 1
        appChoice = Int.random(in: 0..<3)
        userWin = Bool.random()
        
        if count > 9 {
            isShowingAlert = true
        }
    }
    
    func startNewGame() {
        score = 0
        count = 0
//        appChoice = Int.random(in: 0..<3)
//        userWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
