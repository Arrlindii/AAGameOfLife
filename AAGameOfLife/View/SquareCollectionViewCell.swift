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

    override func layoutSubviews() {
        super.layoutSubviews()
        squareView.layer.cornerRadius = squareView.bounds.size.width/2
    }
    
    func configureWithState(_ isAlive: Bool) {
        self.squareView.backgroundColor = isAlive ?  UIColor.mintColor : UIColor.purpleColor
    }
}
