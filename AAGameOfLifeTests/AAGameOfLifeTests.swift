//
//  AAGameOfLifeTests.swift
//  AAGameOfLifeTests
//
//  Created by Arlind Aliu on 18.12.18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import XCTest
@testable import AAGameOfLife

class AAGameOfLifeTests: XCTestCase {
    var game = Game(width: 3, height: 3)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //A live square with two or three live neighbors survives (survival).
    func test_survival() {
        let twoAliveNeighboursGameState = GameState(cells: [Cell.makeDeadCell(), Cell.makeDeadCell(), Cell.makeDeadCell(),
                                                            Cell.makeLiveCell(), Cell.makeLiveCell(), Cell.makeLiveCell(),
                                                            Cell.makeDeadCell(), Cell.makeDeadCell(), Cell.makeDeadCell()])
        game.setInitialState(twoAliveNeighboursGameState)
        XCTAssertTrue(game.state(x: 1, y: 1))
        
        let threeAliveNeighboursGameState = GameState(cells: [Cell.makeDeadCell(), Cell.makeLiveCell(), Cell.makeDeadCell(),
                                                              Cell.makeDeadCell(), Cell.makeLiveCell(), Cell.makeLiveCell(),
                                                              Cell.makeDeadCell(), Cell.makeLiveCell(), Cell.makeDeadCell()])
        game.setInitialState(threeAliveNeighboursGameState)
        XCTAssertTrue(game.state(x: 1, y: 1))
    }
    
    func test_gliderState() {
        let gliderState = GameState(cells:[Cell.makeDeadCell(), Cell.makeLiveCell(), Cell.makeDeadCell(),
                                           Cell.makeDeadCell(), Cell.makeDeadCell(), Cell.makeDeadCell(),
                                           Cell.makeDeadCell(),  Cell.makeLiveCell(), Cell.makeDeadCell()])
        
        game.setInitialState(gliderState)
        
        XCTAssertEqual(game.iterate(), GameState(cells:[Cell.makeDeadCell(), Cell.makeDeadCell(), Cell.makeDeadCell(),
                                                        Cell.makeDeadCell(), Cell.makeDeadCell(), Cell.makeDeadCell(),
                                                        Cell.makeDeadCell(),Cell.makeDeadCell(),Cell.makeDeadCell()
            ]))
    }
    
    //2. A dead square with exactly three live neighbors becomes a live cell (birth).
    func test_birth() {
        let deadCellState = GameState(cells:[Cell.makeLiveCell(), Cell.makeDeadCell(), Cell.makeDeadCell(),
                                             Cell.makeLiveCell(), Cell.makeLiveCell(), Cell.makeDeadCell(),
                                             Cell.makeDeadCell(), Cell.makeDeadCell(), Cell.makeDeadCell()
            ])
        game.setInitialState(deadCellState)
        XCTAssertTrue(game.state(x: 1, y: 0))
    }
    
    //3. In all other cases a cell dies or remains dead. In the case that a live square has zero or one neighbor, it is said to die of loneliness; if it has more than three neighbors, it is said to die of overcrowding.
    func test_death() {
        let lonelyState = GameState(cells: [Cell.makeDeadCell(), Cell.makeDeadCell(), Cell.makeDeadCell(),
                                            Cell.makeDeadCell(), Cell.makeLiveCell(), Cell.makeDeadCell(),
                                            Cell.makeDeadCell(), Cell.makeDeadCell(), Cell.makeDeadCell()])
        game.setInitialState(lonelyState)
        XCTAssertEqual(false, game.state(x: 1, y: 1))
        
        let overcrowdingState = GameState(cells: [Cell.makeLiveCell(), Cell.makeLiveCell(), Cell.makeLiveCell(),
                                                  Cell.makeLiveCell(), Cell.makeLiveCell(), Cell.makeLiveCell(),
                                                  Cell.makeLiveCell(), Cell.makeLiveCell(), Cell.makeLiveCell()])
        game.setInitialState(overcrowdingState)
        XCTAssertEqual(false, game.state(x: 1, y: 1))
    }
}
