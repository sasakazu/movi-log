//
//  movilogFriendDetail.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/13.
//

import UIKit
import Firebase

class movilogFriendDetail: UIViewController {

    //    friend情報
    var friendUserID = ""
    var nickname = ""
    var friendIcon = ""
    var friendArray:[String] = []
    var friendcout:[String] = []
    
    
    @IBOutlet weak var moviFImage: UIImageView!
    @IBOutlet weak var moviFName: UILabel!
    @IBOutlet weak var moviTomo: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(friendUserID)
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(friendUserID)
        
//        friend情報取得
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                self.nickname = document["nickname"] as? String ?? "no name"
                self.friendIcon = document["userIcon"] as? String ?? "no icon"
        
                
                self.moviFName.text = self.nickname
                
//                print(document.data())
                
            } else {
                print("Document does not exist")
            }
            
    

        }
        
        
        
//        映画仲間の数を取得
        
            db.collection("users").document(self.friendUserID).collection("userFollowing").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                    
                    self.friendcout = querySnapshot!.documents.compactMap { $0.data()["followUserID"] as? String }
                    
//                    print(self.friendCount.count)
                    self.moviTomo.setTitle("映画仲間：\(self.friendcout.count)人", for: .normal)

                    }
                }
            }
        
        
        
        //        アイコン表示
            let storageref = Storage.storage().reference(forURL: "gs://movi-log.appspot.com/").child("images").child(friendUserID).child("\(self.friendUserID).jpg")

            self.moviFImage.sd_setImage(with:storageref)

            self.moviFImage.layer.cornerRadius = self.moviFImage.frame.size.width * 0.5
            self.moviFImage.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func unFollowBtn(_ sender: Any) {
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        db.collection("users").document(user!.uid).collection("userFollowing").whereField("followUserID", isEqualTo : friendUserID).getDocuments() { (querySnapshot, err) in
          if let err = err {
            print("Error getting documents: \(err)")
          } else {
            for document in querySnapshot!.documents {
              document.reference.delete()
                
                print("unfollow succusess!")
            }
          }
        }
   
        db.collection("following").document(user!.uid).collection("followingUser").whereField("followID", isEqualTo : friendUserID).getDocuments() { (querySnapshot, err) in
          if let err = err {
            print("Error getting documents: \(err)")
          } else {
            for document in querySnapshot!.documents {
              document.reference.delete()
                
                print("unfollow succusess!")
            }
          }
        }
        
        
    }
    
    

}
