//
//  commentTableViewCell.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/31.
//

import UIKit

class commentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userIcon.layer.cornerRadius = userIcon.frame.size.width * 0.5
        userIcon.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
