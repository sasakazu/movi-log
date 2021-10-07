//
//  TLTableViewCell.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/17.
//

import UIKit
import Firebase

class TLTableViewCell: UITableViewCell {

//    映画情報
    @IBOutlet weak var TLMovieTitle: UILabel!
    @IBOutlet weak var artistLable: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
//    フォローユーザー情報
    @IBOutlet weak var followIcon: UIImageView!
    @IBOutlet weak var followAction: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        followIcon.layer.cornerRadius = followIcon.frame.size.width * 0.5
        followIcon.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    

}
    


