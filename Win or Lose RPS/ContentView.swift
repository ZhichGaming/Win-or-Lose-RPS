//
//  ContentView.swift
//  Win or Lose RPS
//
//  Created by Nick on 2022-08-16.
//

import SwiftUI

let moves: [String] = ["rock", "paper", "scissors"]

struct ContentView: View {
    
    @State private var computerChoice: String = moves[Int.random(in: 0..<3)]
    @State private var shouldWin: Bool = Bool.random()
    @State private var score: Int = 0
    @State private var playerChoice: String = "rock"
    @State private var playerHasPlayed: Bool = false
    @State private var game: Int = 1
    @State private var showingAlert = false
    @State private var showingFinalAlert = false
    @State private var winLoseDraw: String = ""

    
    var body: some View {
        VStack {
            Text("Win or lose RPS")
                .font(.largeTitle)
                .padding(.top)
            Text("Standard rock paper scissors rules\n Fufill the objective below")
                .font(.subheadline)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            HStack {
                // Playerscore
                Text("Score: \(String(score))")
                    .font(.title2)
                    .padding()
                
                // Objective
                Text("Objective: \(shouldWin ? "Win" : "Lose")")
                    .font(.title2)
                }
            Spacer()
            
            // App's move
            ZStack {
                Image(playerHasPlayed ? computerChoice : "question")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(playerHasPlayed ? 10 : 40)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 4))
            }
            .padding(.horizontal, 125)

            Spacer()
            Divider()

            // Your move
            HStack {
                Button() {
                    playerChoice = "rock"
                    showingAlert = true
                    logic()
                } label: {
                    Image("rock")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                }
                .background(Color.red)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .padding()
                Button() {
                    playerChoice = "paper"
                    showingAlert = true
                    logic()
                } label: {
                    Image("paper")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                }
                .background(Color.mint)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .padding()
                Button() {
                    playerChoice = "scissors"
                    showingAlert = true
                    logic()
                } label: {
                    Image("scissors")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(5)
                }
                .background(Color.yellow)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 4))
                .padding()
            }
            .alert(winLoseDraw == "draw" ? "Draw" : "You \(winLoseDraw)!", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    shouldWin.toggle()
                    playerHasPlayed = false
                }
            } message: {
                Text("Your goal was to \(shouldWin ? "win" : "lose"). You played \(playerChoice) and your opponent played \(computerChoice). Current score: \(score)")
            }
            .alert("Your final score was \(score)/10", isPresented: $showingFinalAlert) {
                Button("Restart", role: .cancel) {
                }
            } message: {
                Text(finalScoreMessage())
            }
        }
    }
    
    func logic() {
        playerHasPlayed = true
        computerChoice = moves[Int.random(in: 0..<3)]
        
        if shouldWin {
            if computerChoice == "rock" {
                if playerChoice == "paper" { winLoseDraw = "win"; score += 1 }
                else if playerChoice == "scissors" { winLoseDraw = "lose"; score -= 1 }
                else { winLoseDraw = "draw" }
            } else if computerChoice == "scissors" {
                if playerChoice == "rock" { winLoseDraw = "win"; score += 1 }
                else if playerChoice == "paper" { winLoseDraw = "lose"; score -= 1 }
                else { winLoseDraw = "draw" }
            } else if computerChoice == "paper" {
                if playerChoice == "rock" { winLoseDraw = "lose"; score -= 1 }
                else if playerChoice == "scissors" { winLoseDraw = "win"; score += 1 }
                else { winLoseDraw = "draw" }
            }
        } else if !shouldWin {
            if computerChoice == "rock" {
                if playerChoice == "paper" { winLoseDraw = "lose"; score -= 1 }
                else if playerChoice == "scissors" { winLoseDraw = "win"; score += 1 }
                else { winLoseDraw = "draw" }
            } else if computerChoice == "scissors" {
                if playerChoice == "rock" { winLoseDraw = "lose"; score -= 1 }
                else if playerChoice == "paper" { winLoseDraw = "win"; score += 1 }
                else { winLoseDraw = "draw" }
            } else if computerChoice == "paper" {
                if playerChoice == "rock" { winLoseDraw = "win"; score += 1 }
                else if playerChoice == "scissors" { winLoseDraw = "lose"; score -= 1 }
                else { winLoseDraw = "draw" }
            }
        }
        
        if score < 0 { score = 0 }
        
        if game >= 10 {
            game = 0
            score = 0
            showingFinalAlert = true
        } else {
            game += 1
        }
    }
    
    func finalScoreMessage() -> String {
        if score <= 4 {
            return "You failed! You'll do better next time!"
        } else if score <= 8 {
            return "Not bad! You got pretty good luck!"
        } else if score == 9 {
            return "You almost got a full score!"
        } else {
            return "Congratulations! You got a full score!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
