//
//  Game.swift
//  AAGameOfLife
//
//  Created by Arlind Aliu on 18.12.18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import Foundation

typealias GameStateObserver = ((GameState) -> Void)?

class Game {
    let width: Int
    let height: Int
    var currentState: GameState
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        let cells = Array(repeating: Cell.makeDeadCell(), count: width*height)
        currentState = GameState(cells: cells)
    }
    
    func addStateObserver(_ observer: GameStateObserver) {
        observer?(generateInitialState())
        Timer.scheduledTimer(withTimeInterval: 0.33, repeats: true) { _ in
            observer?(self.iterate())
        }
    }
    
    func iterate() -> GameState  {
        var nextState = currentState
        for i in 0...width - 1 {
            for j in 0...height - 1 {
                let positionInTheArray = j*width + i
                nextState[positionInTheArray] = Cell(isAlive: state(x: i, y: j))
            }
        }
        self.currentState = nextState
        return nextState
    }
    
    func state(x: Int, y: Int) -> Bool {
        var numberOfAliveNeighbours = 0
        let previousPosition = x + y*width
        for i in x-1...x+1 {
            for j in y-1...y+1 {
                let positionInTheArray = j*width + i
                guard positionInTheArray >= 0 && positionInTheArray < width*height && previousPosition != positionInTheArray else {continue}
                if currentState[positionInTheArray].isAlive {
                    numberOfAliveNeighbours += 1
                }
            }
        }
        
        let wasPrevioslyAlive = currentState[previousPosition].isAlive
        if wasPrevioslyAlive {
            return numberOfAliveNeighbours == 2 || numberOfAliveNeighbours == 3
        } else { //Dead
            return numberOfAliveNeighbours == 3
        }
    }
    
    func setInitialState(_ state: GameState) {
        currentState = state
    }
    
    /*
     We should feed the game an initial state to start with
     we can do it with random generated numbers i.e
     */
    func generateInitialState() -> GameState {
        let initialStatePoints = [1,16, 31, 96, 97, 111, 112, 20, 21, 36, 37, 137, 153, 168, 167,
                                  156, 172, 187, 158, 173, 213, 214, 41, 56, 71, 76, 91, 92, 107,
                                  116, 131, 101, 162, 163, 177, 178, 17, 117
        ]
        for point in initialStatePoints{
            currentState[point] = Cell.makeLiveCell()
        }
        return self.currentState
    }
    
}
