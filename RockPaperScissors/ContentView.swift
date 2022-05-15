//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alex Po on 14.05.2022.
//  ✊✋✌️

import SwiftUI

struct ContentView: View {
    let figures = ["Rock", "Paper", "Scissors"]
    
    let winningCombination = ["Rock": "Paper", "Paper": "Scissors", "Scissors": "Rock"]
    
    @State private var userWin = Bool.random()
    @State private var appChoice = Int.random(in: 0..<3)
    @State private var score: Int = 0
    @State private var count = 0
    @State private var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Score: \(score)")
                    .font(.title)
                Text("I chose \(figures[appChoice])")
                    .font(.headline)
                    .padding(.vertical)
                Text("You \(userWin ? "WIN" : "LOOSE")")
                    .font(.headline)
                    .padding(.vertical)
                Text("Make your choice:")
                    .font(.subheadline)
                HStack {
                    Button("✊") {
                        updateScore(figure: "Rock")
                    }
                    Button("✋") {
                        updateScore(figure: "Paper")
                    }
                    Button("✌️") {
                        updateScore(figure: "Scissors")
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
    
    func WinOrLoose(appFigure: String, userFigure: String) -> Bool? {
        if  appFigure == userFigure {
            return nil
        } else if userFigure == winningCombination[appFigure] {
            return true
        }
        return false
    }
    
    func updateScore(figure: String) {
        if userWin == WinOrLoose(appFigure: figures[appChoice], userFigure: figure) {
            score += 1
            count += 1
        }
        if count < 10 {
            appChoice = Int.random(in: 0..<3)
            userWin = Bool.random()
        } else {
            isShowingAlert = true
        }
    }
    
    func startNewGame() {
        score = 0
        count = 0
        appChoice = Int.random(in: 0..<3)
        userWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
