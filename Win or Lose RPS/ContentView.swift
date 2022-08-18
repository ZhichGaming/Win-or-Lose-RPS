//
//  ContentView.swift
//  Win or Lose RPS
//
//  Created by Nick on 2022-08-16.
//

import SwiftUI

let moves: [String] = ["rock", "paper", "scissors"]

struct ContentView: View {
    
    @State var currentChoice: Int = Int.random(in: 0..<3)
    @State var shouldWin: Bool = Bool.random()
    @State var playerScore: Int = 0
    @State var playerChoice: String = "rock"
    @State var playerHasPlayed: Bool = false
    @State var game: Int = 1
    
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
                Circle()
                    .fill(Color.gray)
                    .overlay(Circle().stroke(Color.black, lineWidth: 4))
                Image(playerHasPlayed ? moves[currentChoice] : "question")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(playerHasPlayed ? 10 : 40)
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
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 4))
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
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 4))
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
        }
    }
    
    func appPlay(_ playerChoice: String) {
        playerHasPlayed = true
        currentChoice = Int.random(in: 0..<3)
        self.playerChoice = playerChoice
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
