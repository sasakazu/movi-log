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

    
    @IBOutlet weak var friendsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func followTapped(_ sender: Any) {
        
//        let db = Firestore.firestore()
//
//        let user = Auth.auth().currentUser
//
//        db.collection("following").document(user!.uid).collection("userFollowing").document(fuid).setData([
//            "follow": true
//
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//
//        }

//    }
     
        
    
    
    }
    
    
}
