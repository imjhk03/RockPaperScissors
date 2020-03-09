//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by JHK on 20. 02. 29..
//  Copyright © 2020 JHK. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var game = Game()
    
    var body: some View {
        ZStack {
            if game.gameState == .start || game.gameState == .draw {
                Color.gray
                    .edgesIgnoringSafeArea(.all)
            } else if game.gameState == .win {
                Color.green
                    .edgesIgnoringSafeArea(.all)
            } else if game.gameState == .lose {
                Color.red
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack(spacing: 30) {
                if game.isDifficultySet {
                    if game.isEndGame {
                        Text("GAME END")
                            .foregroundColor(.white)
                            .font(.system(size: 50))
                        Button(action: {
                            self.game.restartGame()
                        }) {
                            Text("Play Again?")
                                .foregroundColor(.white)
                        }
                    }
                    
                    VStack(spacing: 10) {
                        Text("Round \(game.playedCount) / 10")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                        
                        Text("Player's score: \(game.playersScore)")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    
                    VStack(spacing: 20) {
                        Text("🤖")
                            .font(.system(size: 70))
                        MoveEmojiView(move: game.appChoice)
                        Text(game.round.rawValue)
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    
                    MoveStackView(totalCount: game.moves.count) { index in
                        Button(action: {
                            self.game.play(self.game.moves[index])
                        }) {
                            MoveEmojiView(move: self.game.moves[index])
                        }
                        .frame(width: 70, height: 70)
                        .allowsHitTesting(!self.game.isEndGame)
                    }
                    .frame(width: 250, height: 70)
                } else {
                    VStack(spacing: 20) {
                        Text("Rock Paper Scissor")
                            .font(.largeTitle)
                            .foregroundColor(.white)

                        MoveStackView(totalCount: game.moves.count) { index in
                            Button(action: {
                                self.game.play(self.game.moves[index])
                            }) {
                                MoveEmojiView(move: self.game.moves[index])
                            }
                            .frame(width: 70, height: 70)
                            .allowsHitTesting(!self.game.isEndGame)
                        }
                        .frame(width: 250, height: 70)

                        Text("Choose difficulty")
                            .font(.title)
                            .foregroundColor(.white)

                        HStack(spacing: 20) {
                            Button(action: {
                                self.game.difficulty = .easy
                                self.game.isDifficultySet = true
                            }) {
                                Text("Easy")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                self.game.difficulty = .hard
                                self.game.isDifficultySet = true
                            }) {
                                Text("Hard")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
        }
        .alert(isPresented: $game.showingScore) {
            if !game.isEndGame {
                let alert = Alert(title: Text("\(game.gameStateString)!"), message: Text("Your score is \(game.playersScore)"), dismissButton: .default(Text("Continue")) {
                    self.game.playAgain()
                    })
                return alert
            } else {
                let alert = Alert(title: Text("Game End"), message: Text("Your score is \(game.playersScore)"), dismissButton: nil)
                return alert
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
