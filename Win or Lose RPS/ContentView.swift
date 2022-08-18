//
//  ContentView.swift
//  Win or Lose RPS
//
//  Created by Nick on 2022-08-16.
//

import SwiftUI

let moves: [String] = ["rock", "paper", "scissors"]

struct ContentView: View {
    
    @State var currentChoice: String = moves[Int.random(in: 0..<3)]
    @State var shouldWin: Bool = Bool.random()
    @State var playerScore: Int = 0
    var playerChoice: String = "rock"
    var game: Int = 1
    
    var body: some View {
        VStack {
            Text("Win or lose RPS")
                .font(.largeTitle)
                .padding(.top)
            Text("Standard rock paper scissors rules but you win by winning or losing according to below")
                .font(.subheadline)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            // Playerscore
            Text("Current score: \(String(playerScore))")
                .padding()
            
            // Win or lose
            Text("Win objective: \(shouldWin ? "Win" : "Lose")")
            Spacer()
            
            // App's move
                        
            // Your move
            HStack {
                Button() {
                    
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
            
            Spacer()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
