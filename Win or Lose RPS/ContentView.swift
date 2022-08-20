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
    @State private var playerScore: Int = 0
    @State private var playerChoice: String = "rock"
    @State private var playerHasPlayed: Bool = false
    @State private var game: Int = 1
    @State private var showingAlert = false
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
                Text("Score: \(String(playerScore))")
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
                    appPlay("rock")
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
                    appPlay("paper")
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
                    appPlay("scissors")
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
                    playerHasPlayed = false
                }
            } message: {
                Text("Your goal was to \(shouldWin ? "win" : "lose"). You played \(playerChoice) and your opponent played \(computerChoice). Current score: \(playerScore)")
            }
        }
    }
    
    func appPlay(_ playerChoice: String) {
        playerHasPlayed = true
        computerChoice = moves[Int.random(in: 0..<3)]
        self.playerChoice = playerChoice
        showingAlert = true
        winner()
    }
    
    func winner() {
        if shouldWin {
            if computerChoice == "rock" {
                if playerChoice == "paper" { winLoseDraw = "win"; playerScore += 1 }
                else if playerChoice == "scissors" { winLoseDraw = "lose"; playerScore -= 1 }
                else { winLoseDraw = "draw" }
            } else if computerChoice == "scissors" {
                if playerChoice == "rock" { winLoseDraw = "win"; playerScore += 1 }
                else if playerChoice == "paper" { winLoseDraw = "lose"; playerScore -= 1 }
                else { winLoseDraw = "draw" }
            } else if computerChoice == "paper" {
                if playerChoice == "rock" { winLoseDraw = "lose"; playerScore -= 1 }
                else if playerChoice == "scissors" { winLoseDraw = "win"; playerScore += 1 }
                else { winLoseDraw = "draw" }
            }
        } else if !shouldWin {
            if computerChoice == "rock" {
                if playerChoice == "paper" { winLoseDraw = "lose"; playerScore -= 1 }
                else if playerChoice == "scissors" { winLoseDraw = "win"; playerScore += 1 }
                else { winLoseDraw = "draw" }
            } else if computerChoice == "scissors" {
                if playerChoice == "rock" { winLoseDraw = "lose"; playerScore -= 1 }
                else if playerChoice == "paper" { winLoseDraw = "win"; playerScore += 1 }
                else { winLoseDraw = "draw" }
            } else if computerChoice == "paper" {
                if playerChoice == "rock" { winLoseDraw = "win"; playerScore += 1 }
                else if playerChoice == "scissors" { winLoseDraw = "lose"; playerScore -= 1 }
                else { winLoseDraw = "draw" }
            }
        }
        
        if playerScore < 0 { playerScore = 0 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
