//
//  TableViewCustomCell.swift
//  MovieApp
//
//  Created by kuka apps on 3.09.2019.
//  Copyright © 2019 kuka apps. All rights reserved.
//

import UIKit

class TableViewCustomCell: UITableViewCell {

    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
