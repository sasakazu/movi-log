//
//  friendDetaiView.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/11.
//

import UIKit
import Firebase

class friendDetaiView: UIViewController {
 
    var friendUser = ""
    
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsLabel.text = friendUser

        // Do any additional setup after loading the view.
    }
    

    @IBAction func followTapped(_ sender: Any) {
        
        let db = Firestore.firestore()

        let user = Auth.auth().currentUser

        db.collection("following").document(user!.uid).collection("userFollowing").document(friendUser).setData([
            "follow": true

        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")

        }
        }
        
    }
    
    
    @IBAction func followingBtn(_ sender: Any) {
    }
    
    @IBAction func follweredBtn(_ sender: Any) {
    }
    
    
}
