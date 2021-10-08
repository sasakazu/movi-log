//
//  searchFriendFollowingCell.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/08.
//

import UIKit

class searchFriendFollowingCell: UITableViewCell {

    
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followingIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        followingIcon.layer.cornerRadius = followingIcon.frame.size.width * 0.5
        followingIcon.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
