//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by kuka apps on 5.09.2019.
//  Copyright © 2019 kuka apps. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var actorsImage: UIImageView!
    @IBOutlet weak var actorsCharacter: UILabel!
    @IBOutlet weak var actorsName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
