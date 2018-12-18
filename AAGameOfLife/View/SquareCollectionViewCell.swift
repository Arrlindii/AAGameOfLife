//
//  SquareCollectionViewCell.swift
//  AAGameOfLife
//
//  Created by Arlind Aliu on 18.12.18.
//  Copyright © 2018 Arlind Aliu. All rights reserved.
//

import UIKit

class SquareCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var squareView: UIView!
    func configureWith(_ state: Bool) {
        squareView.backgroundColor = state ? .black : .white
    }
}
