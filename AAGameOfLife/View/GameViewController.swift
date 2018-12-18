//
//  GameViewController.swift
//  AAGameOfLife
//
//  Created by Arlind Aliu on 18.12.18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: [Cell]  = []
    let width = 20
    let height = 20
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Game(width: width, height: height)
        game.addStateObserver { [weak self] state in
            self?.display(state)
        }
    }
    
    func display(_ state: GameState) {
        self.dataSource = state.cells
        collectionView.reloadData()
    }
}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return width * height
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SquareCollectionViewCell.self)", for: indexPath) as! SquareCollectionViewCell
        cell.configureWith(dataSource[indexPath.item].isAlive)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let squareSize: CGFloat = self.view.bounds.width / CGFloat(width)
        return CGSize(width: squareSize, height: squareSize)
    }
    
}
