//
//  movilogFriendDetail.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/13.
//

import UIKit
import Firebase
import SDWebImage

class movilogFriendDetail: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
    

    //    friend情報
    var friendUserID = ""
    var nickname = ""
    var friendIcon = ""
    var friendArray:[String] = []
    var friendcout:[String] = []
    
//    collection
    var imageFItems:[String] = []
    var imageData = ""
    
    @IBOutlet weak var moviFImage: UIImageView!
    @IBOutlet weak var moviFName: UILabel!
    @IBOutlet weak var moviTomo: UIButton!
    @IBOutlet weak var movieFColloection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieFColloection.delegate = self
        movieFColloection.dataSource = self

//        print(friendUserID)
        
        let nib = UINib(nibName: "movilogFDetailCell", bundle: nil)
        
        self.movieFColloection.register(nib, forCellWithReuseIdentifier: "Cell")
        
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
        
        
//        映画ポスト取得
        
        
        db.collection("users").document(self.friendUserID).collection("post").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {

                
                self.imageFItems = querySnapshot!.documents.compactMap { $0.data()["largeImageUrl"] as? String }
                

                }
            
            self.movieFColloection.reloadData()
            
        
            }
        
        }
        
        
//        映画仲間の数を取得
        
            db.collection("users").document(self.friendUserID).collection("userFollowing").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                    
                    self.friendcout = querySnapshot!.documents.compactMap { $0.data()["followUserID"] as? String }
                    
                    print(self.friendcout)
                    
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageFItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! movilogFDetailCell
        
        
        self.imageData = imageFItems[indexPath.row]
            
        cell.movilogImageView.sd_setImage(with: URL(string:imageData), placeholderImage: UIImage(named: "placeholder"))


        
        return cell
        
    }
    
    
    
//    @IBAction func friendBtn(_ sender: Any) {
//
//
//    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "goNakama" {
//            if let nextVC = segue.destination as? movieFriendTableView {
//
//            nextVC.followUserIDArray = friendcout
//            nextVC.reciveYourID = friendUserID
//
//
//
//        }
//    }
//
//
//}

}
