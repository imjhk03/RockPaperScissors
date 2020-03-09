//
//  Moves.swift
//  RockPaperScissors
//
//  Created by JHK on 20. 03. 01..
//  Copyright © 2020 JHK. All rights reserved.
//

import Foundation

enum Moves: CaseIterable {
    case rock, paper, scissor
    
    var emoji: String {
        switch self {
        case .rock:
            return "👊"
        case .paper:
            return "✋"
        case .scissor:
            return "✌️"
        }
    }
    
    static var random: Moves {
        return Moves.allCases.randomElement() ?? .rock
    }
    
}
