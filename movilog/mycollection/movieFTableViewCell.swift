//
//  movieFTableViewCell.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/01.
//

import UIKit

class movieFTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieFLabel: UILabel!
    @IBOutlet weak var movieFImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
