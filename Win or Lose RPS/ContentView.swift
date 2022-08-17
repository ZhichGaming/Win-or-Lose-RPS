//
//  ContentView.swift
//  Win or Lose RPS
//
//  Created by Nick on 2022-08-16.
//

import SwiftUI

let moves: [String] = ["Rock", "Paper", "Scissors"]

struct ContentView: View {
    
    @State var currentChoice: String = moves[Int.random(in: 0..<3)]
    @State var shouldWin: Bool = Bool.random()
    @State var playerScore: Int = 0
    
    var body: some View {
        VStack {
            Text("Win or lose RPS")
                .font(.largeTitle)
                .padding(.top)
            Text("Standard rock paper scissors rules but you win by winning or losing according to below")
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            // Playerscore
            
            // App's move
            
            // Win or lose
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
