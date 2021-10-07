//
//  profileViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/29.
//

import UIKit
import Firebase
import SDWebImage

class profileViewController: UIViewController {

    
    @IBOutlet weak var profileIcon: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileIcon.layer.cornerRadius = profileIcon.frame.size.width * 0.5
        profileIcon.clipsToBounds = true

        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
        let profileRef = db.collection("users").document(user!.uid)

        profileRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"

                
                self.profileName.text = document["nickname"] as? String ?? "no name"
                
        
                
                
            } else {
                print("Document does not exist")
            }
        }
        
        if let user = Auth.auth().currentUser {
//        ユーザーアイコンの取得
            let storageref = Storage.storage().reference(forURL: "gs://movi-log.appspot.com/").child("images").child(user.uid).child("\(user.uid).jpg")

        profileIcon.sd_setImage(with:storageref)
        
//        print("my icon is url\(storageref)")
        
        
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    


}
