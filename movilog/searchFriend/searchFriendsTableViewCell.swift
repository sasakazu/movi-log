//
//  searchFriendsTableViewCell.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/11.
//

import UIKit
import Firebase



class searchFriendsTableViewCell: UITableViewCell {

    
//    var followID = ""

    
    @IBOutlet weak var friendIconView: UIImageView!
    @IBOutlet weak var friendsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        friendIconView.layer.cornerRadius = friendIconView.frame.size.width * 0.5
        friendIconView.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
