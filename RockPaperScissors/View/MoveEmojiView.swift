//
//  MoveEmojiView.swift
//  RockPaperScissors
//
//  Created by JHK on 20. 03. 01..
//  Copyright © 2020 JHK. All rights reserved.
//

import SwiftUI

struct MoveEmojiView: View {
    var move: Moves
    
    var body: some View {
        Text(move.emoji)
            .font(.system(size: 70))
    }
    
}
