//
//  MoveEmoji.swift
//  RockPaperScissors
//
//  Created by JHK on 20. 03. 01..
//  Copyright © 2020 JHK. All rights reserved.
//

import SwiftUI

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
