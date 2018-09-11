//
//  MoviesTableViewCell.swift
//  TestRappi
//
//  Created by Felipe Aragon on 9/10/18.
//  Copyright © 2018 Felipe Aragon. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var numvotesLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
