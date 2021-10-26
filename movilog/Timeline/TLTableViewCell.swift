//
//  TLTableViewCell.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/17.
//

import UIKit
import Firebase

class TLTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tLView: UIView!
    
    
//    映画情報
    @IBOutlet weak var TLMovieTitle: UILabel!
    @IBOutlet weak var artistLable: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var postDate: UILabel!
//    フォローユーザー情報
    @IBOutlet weak var followIcon: UIImageView!
    @IBOutlet weak var followAction: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        followIcon.layer.cornerRadius = followIcon.frame.size.width * 0.5
        followIcon.clipsToBounds = true
        
        tLView.layer.cornerRadius = 6
        // 影の方向（width=右方向、height=下方向、CGSize.zero=方向指定なし）
        tLView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        // 影の色
        tLView.layer.shadowColor = UIColor.black.cgColor
        // 影の濃さ
        tLView.layer.shadowOpacity = 0.2
        // 影をぼかし
        tLView.layer.shadowRadius = 4
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    

}
    


