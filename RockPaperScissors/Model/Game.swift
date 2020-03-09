//
//  Game.swift
//  RockPaperScissors
//
//  Created by JHK on 20. 03. 08..
//  Copyright © 2020 JHK. All rights reserved.
//

import Foundation

struct Game {
    var moves: [Moves] = [.rock, .paper, .scissor]
    let maxGamePlay = 10
    
    var appChoice: Moves = Moves.random
    var round: RoundState = RoundState.random
    var isDifficultySet: Bool = false
    var difficulty: Difficulty = .easy {
        didSet {
            if self.difficulty == .hard {
                self.moves.shuffle()
            } else if self.difficulty == .easy {
                self.moves = [.rock, .paper, .scissor]
            }
        }
    }
    
    var playersScore = 0
    var showingScore = false
    var gameState: GameState = .start
    var gameStateString = ""
    
    var playedCount = 1
    var isEndGame = false
    
    func compare(_ sign: Moves) -> GameState {
        let appSelect = appChoice
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
    
    mutating func play(_ sign: Moves) {
        let gameState = compare(sign)
        switch gameState {
        case .win:
            switch round {
            case .win:
                playersScore += 1
                gameStateString = GameState.win.rawValue
                self.gameState = .win
            case .lose:
                if playersScore > 0 {
                    playersScore -= 1
                }
                gameStateString = GameState.lose.rawValue
                self.gameState = .lose
            }
        case .lose:
            switch round {
            case .win:
                if playersScore > 0 {
                    playersScore -= 1
                }
                gameStateString = GameState.lose.rawValue
                self.gameState = .lose
            case .lose:
                playersScore += 1
                gameStateString = GameState.win.rawValue
                self.gameState = .win
            }
        case .draw:
            gameStateString = GameState.draw.rawValue
            self.gameState = .draw
        default:
            break
        }
        if playedCount >= maxGamePlay {
            playedCount = maxGamePlay
            self.gameState = .start
            isEndGame = true
        }
        showingScore = true
    }
    
    mutating func playAgain() {
        self.gameState = .start
        if playedCount < maxGamePlay {
            playedCount += 1
            appChoice = Moves.random
            round = RoundState.random
            if difficulty == .hard {
                moves.shuffle()
            }
        }
    }
    
    mutating func restartGame() {
        gameState = .start
        appChoice = Moves.random
        round = RoundState.random
        showingScore = false
        playedCount = 1
        playersScore = 0
        gameStateString = GameState.start.rawValue
        isEndGame = false
        isDifficultySet = false
    }
}

enum GameState: String {
    case start = "Start"
    case win = "Win"
    case lose = "Lose"
    case draw = "Draw"
}

enum RoundState: String, CaseIterable {
    case win = "Win"
    case lose = "Lose"
    
    static var random: RoundState {
        return RoundState.allCases.randomElement() ?? .win
    }
}

enum Difficulty {
    case easy, hard
}
