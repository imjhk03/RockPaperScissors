//
//  MoveStackView.swift
//  RockPaperScissors
//
//  Created by JHK on 20. 03. 01..
//  Copyright © 2020 JHK. All rights reserved.
//

import SwiftUI

struct MoveStackView<Content: View>: View {
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
