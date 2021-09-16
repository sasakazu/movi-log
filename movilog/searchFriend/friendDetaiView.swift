//
//  friendDetaiView.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/11.
//

import UIKit
import Firebase
import SDWebImage

class friendDetaiView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var friendUserID = ""
    var nickname = ""
    
//    コレクション
    private var movietitleItems: [String] = []
    private var imageItems: [String] = []
    private var artistItems: [String] = []
    private var saleItems: [String] = []
    private var reviewItems: [String] = []
    
//    映画の中身
    var collectionItem: [String:Any] = [:]
    var imageData = ""
    var titleData = ""
    var artistData = ""
    var saleDateData = ""
    var reviewData = ""
    
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nib = UINib(nibName: "friendCollectionViewCell", bundle: nil)
            
        self.friendsCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
        let db = Firestore.firestore()

        let user = Auth.auth().currentUser

//        ユーザー情報を取得
        
        let docRef = db.collection("users").document(friendUserID)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                self.nickname = document["nickname"] as? String ?? "no name"
                
                self.friendsLabel.text = self.nickname
                

                
                
            } else {
                print("Document does not exist")
            }
        }
        
        
//        コレクションを取得
        db.collection("users").document(friendUserID).collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

//                    titleを取得
                    self.movietitleItems = querySnapshot!.documents.compactMap { $0.data()["title"] as? String }
                    
                    self.imageItems = querySnapshot!.documents.compactMap { $0.data()["largeImageUrl"] as? String }
                   
                    self.artistItems = querySnapshot!.documents.compactMap { $0.data()["artistName"] as? String }
                    
                    self.saleItems = querySnapshot!.documents.compactMap { $0.data()["salesDate"] as? String }
                    
                    self.reviewItems = querySnapshot!.documents.compactMap { $0.data()["reviewAverage"] as? String }
                    
                    self.collectionItem = document.data()
                    
                }
                    
                // コレクションビューを更新
                    self.friendsCollectionView.reloadData()

                    
                }
            
            }
     

        
    }
    

    @IBAction func followTapped(_ sender: Any) {
        
        let db = Firestore.firestore()

        let user = Auth.auth().currentUser

        db.collection("following").document(user!.uid).collection("userFollowing").document(friendUserID).setData([
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! friendCollectionViewCell
        
        self.imageData = imageItems[indexPath.row]
            
        cell.friendcollectionImage.sd_setImage(with: URL(string:imageData), placeholderImage: UIImage(named: "placeholder.png"))

        return cell
        
    }
    
    // Cell が選択された場合
      func collectionView(_ collectionView: UICollectionView,
                            didSelectItemAt indexPath: IndexPath) {
   
        self.imageData = imageItems[indexPath.row]
        self.titleData = movietitleItems[indexPath.row]
        self.artistData = artistItems[indexPath.row]
        self.saleDateData = saleItems[indexPath.row]
        self.reviewData = reviewItems[indexPath.row]
        
        performSegue(withIdentifier: "goFriendMovieDetail",sender: nil)
          
          
   
      }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "goFriendMovieDetail") {
            let subVC:friendMovieDetailViewController = (segue.destination as? friendMovieDetailViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
          subVC.ImageHako = imageData
          subVC.movieHako = titleData
          subVC.movieArtist = artistData
          subVC.movieSaleDate = saleDateData
          subVC.movieReview = reviewData
          
        }
    }
    
    
}
