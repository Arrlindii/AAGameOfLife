//
//  GameState.swift
//  AAGameOfLife
//
//  Created by Arlind Aliu on 18.12.18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import Foundation

struct GameState {
    var cells: [Cell] = []
    
    subscript(index: Int) -> Cell {
        get {
            return cells[index]
        } set {
            cells[index] = newValue
        }
    }
}

extension GameState: Equatable {
    public static func == (lhs: GameState, rhs: GameState) -> Bool {
        for lhsCell in lhs.cells {
            for rhsCell in rhs.cells {
                if lhsCell.isAlive != rhsCell.isAlive {
                    return false
                }
            }
        }
        return true
    }
}
