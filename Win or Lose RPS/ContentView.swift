//
//  ContentView.swift
//  Win or Lose RPS
//
//  Created by Nick on 2022-08-16.
//

import SwiftUI

let moves: [String] = ["rock", "paper", "scissors"]

struct PlayerButton: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .background(color)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 4))
            .padding()
    }
}

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
        ZStack {
            RadialGradient(stops: [
                .init(color: Color.purple, location: 0.4),
                .init(color: Color(red: 245/256, green: 225/256, blue: 253/256), location: 0.4),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                // Title and description
                Group {
                    Text("Win or lose RPS")
                        .font(.largeTitle.weight(.bold))
                        .padding(.top)
                    Text("Standard rock paper scissors rules\n Fufill the objective below")
                        .font(.subheadline)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        // Playerscore
                        Text("Score: \(String(score))")
                            .font(.title2.weight(.semibold))
                            .padding(.top, 5)
                        
                        // Objective
                        Text("Objective: \(shouldWin ? "Win" : "Lose")")
                            .font(.title2.weight(.semibold))
                            .padding(.top, 5)
                        }
                    Text("Game \(game)/10")
                        .font(.title.weight(.medium))
                        .padding()
                }
                .foregroundColor(Color(red: 250/256, green: 240/256, blue: 256/256))
                Spacer()
                
                // App's move
                ZStack {
                    Image(playerHasPlayed ? computerChoice : "question")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .frame(width: 150, height: 150, alignment: .center)
                }
                Spacer()

                // Your move
                ZStack {
                    RoundedRectangle(cornerRadius: 39)
                        .foregroundColor(Color(red: 206/256,green: 157/256, blue: 217/256))
                        .frame(maxWidth: .infinity, maxHeight: 120, alignment: .center)
                        .shadow(color: .purple, radius: 5, x: 4, y: 5)
                    
                    HStack(spacing: 0) {
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
                        .modifier(PlayerButton(color: Color(red: 206/256,green: 157/256, blue: 217/256)))
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
                        .modifier(PlayerButton(color: Color(red: 206/256,green: 157/256, blue: 217/256)))
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
                        .modifier(PlayerButton(color: Color(red: 206/256,green: 157/256, blue: 217/256)))
                    }
                }
                .padding()
                
                // Results alert
                .alert(winLoseDraw == "draw" ? "Draw" : "You \(winLoseDraw)!", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                        shouldWin.toggle()
                        playerHasPlayed = false
                        
                        if game >= 10 {
                            game = 0
                            score = 0
                            showingFinalAlert = true
                        } else {
                            game += 1
                        }
                    }
                } message: {
                    Text("Your goal was to \(shouldWin ? "win" : "lose"). You played \(playerChoice) and your opponent played \(computerChoice). Current score: \(score)")
                }
                
                // Final results alert
                .alert("Your final score was \(score)/10", isPresented: $showingFinalAlert) {
                    Button("Restart", role: .cancel) {
                    }
                } message: {
                    Text(finalScoreMessage())
                }
                .shadow(color: .black, radius: 1)
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
