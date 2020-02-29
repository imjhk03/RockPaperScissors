//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by JHK on 20. 02. 29..
//  Copyright © 2020 JHK. All rights reserved.
//

/*
 
 * Views: Total 2
    1. MoveEmoji
        -> a View that shows moves with emoji and font style
    2. MovesStack
        -> a stack that contains buttons of moves
 
 * Models: Total 2
    1. GameState
    2. Moves
 
 */

import SwiftUI

enum GameState {
    case start, win, lose, draw
}

enum Moves {
    case rock, paper, scissor
}

struct MoveEmoji: View {
    var move: Moves
    
    var body: some View {
        Text(emoji(move))
            .font(.system(size: 70))
    }
    
    func emoji(_ move: Moves) -> String {
        if move == .rock {
            return "👊"
        } else if move == .paper {
            return "✋"
        } else if move == .scissor {
            return "✌️"
        } else {
            return ""
        }
    }
}

struct MovesStack<Content: View>: View {
    let totalCount: Int
    let content: (Int) -> Content

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0..<totalCount) { index in
                self.content(index)
            }
        }
    }
}

struct ContentView: View {
    let moves: [Moves] = [.rock, .paper, .scissor]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var playersScore = 0
    @State private var showingScore = false
    @State private var gameState: GameState = .start
    @State private var gameStateString = ""
    
    @State private var playedCount = 1
    @State private var isEndGame = false
    
    var body: some View {
        ZStack {
            if gameState == .start || gameState == .draw {
                Color.gray
                    .edgesIgnoringSafeArea(.all)
            } else if gameState == .win {
                Color.green
                    .edgesIgnoringSafeArea(.all)
            } else if gameState == .lose {
                Color.red
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack(spacing: 30) {
                if isEndGame {
                    Text("GAME END")
                        .foregroundColor(.white)
                        .font(.system(size: 50))
                }
                
                VStack(spacing: 20) {
                    Text("🤖")
                        .font(.system(size: 70))
                    MoveEmoji(move: moves[appChoice])
                    Text(shouldWin ? "Win" : "Lose")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                MovesStack(totalCount: moves.count) { index in
                    Button(action: {
                        self.play(self.moves[index])
                    }) {
                        MoveEmoji(move: self.moves[index])
                    }
                    .frame(width: 70, height: 70)
                    .allowsHitTesting(!self.isEndGame)
                }
                .frame(width: 250, height: 70)
                
                Text("Player's score: \(playersScore)")
            }
        }
        .alert(isPresented: $showingScore) {
            if !isEndGame {
                let alert = Alert(title: Text("\(gameStateString)!"), message: Text("Your score is \(playersScore)"), dismissButton: .default(Text("Continue")) {
                    self.playAgain()
                    })
                return alert
            } else {
                let alert = Alert(title: Text("Game End"), message: Text("Your score is \(playersScore)"), dismissButton: nil)
                return alert
            }
        }
    }
    
    func compare(_ sign: Moves) -> GameState {
        let appSelect = moves[appChoice]
        let playerSelect = sign
        switch appSelect {
        case .rock:
            switch playerSelect {
            case .rock:
                return .draw
            case .paper:
                return .win
            case .scissor:
                return .lose
            }
        case .paper:
            switch playerSelect {
            case .rock:
                return .lose
            case .paper:
                return .draw
            case .scissor:
                return .win
            }
        case .scissor:
            switch playerSelect {
            case .rock:
                return .win
            case .paper:
                return .lose
            case .scissor:
                return .draw
            }
        }
    }
    
    func play(_ sign: Moves) {
        let gameState = compare(sign)
        switch gameState {
        case .win:
            if shouldWin {
                playersScore += 1
                gameStateString = "Win"
                self.gameState = .win
            } else {
                if playersScore > 0 {
                    playersScore -= 1
                }
                gameStateString = "Lose"
                self.gameState = .lose
            }
        case .lose:
            if shouldWin {
                if playersScore > 0 {
                    playersScore -= 1
                }
                gameStateString = "Lose"
                self.gameState = .lose
            } else {
                playersScore += 1
                gameStateString = "Win"
                self.gameState = .win
            }
        case .draw:
            gameStateString = "Draw"
            self.gameState = .draw
        default:
            break
        }
        playedCount += 1
        if playedCount > 10 {
            self.gameState = .start
            isEndGame = true
        }
        showingScore = true
    }
    
    func playAgain() {
        gameState = .start
        if playedCount < 10 {
            appChoice = Int.random(in: 0...2)
            shouldWin = Bool.random()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
