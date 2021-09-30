//
//  movilog.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/08/13.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseStorageUI

class movilog: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    private var titleItems: [String] = []
    private var imageItems: [String] = []
    private var artistItems: [String] = []
    private var saleDataItems: [String] = []
    private var reviewItems: [String] = []
    
//    映画情報
    var collectionItem: [String:Any] = [:]
    var imageData = ""
    var titleData = ""
    var artistData = ""
    var saleDateData = ""
    var reviewData = ""
    
//    ユーザー情報
    var nickname = ""
    var friendCount:[String] = []
    
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var movilogColleciton: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var movieFriend: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()

        let user = Auth.auth().currentUser
            
    
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        
        self.movilogColleciton.register(nib, forCellWithReuseIdentifier: "Cell")
        
        let db = Firestore.firestore()
        
//        ユーザー情報を取得
        let docRef = db.collection("users").document(user!.uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
                
                self.nickname = document["nickname"] as? String ?? "no name"
                
                //ボタンにユーザーネームの表示
                self.username.setTitle("\(self.nickname) >", for: UIControl.State.normal)
//                print(self.nickname)
                
                
            } else {
                print("Document does not exist")
            }
        }
        
//        postを取得
        db.collection("users").document(user!.uid).collection("post").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

//                    print(document.data().count)
                    
//                    print("\(document.documentID) => \(String(describing: documents.data().count))")

//                    titleを取得
                    self.titleItems = querySnapshot!.documents.compactMap { $0.data()["title"] as? String }
                    
                    self.imageItems = querySnapshot!.documents.compactMap { $0.data()["largeImageUrl"] as? String }
                    
                    self.artistItems = querySnapshot!.documents.compactMap { $0.data()["artistName"] as? String }
                  
                    self.saleDataItems = querySnapshot!.documents.compactMap { $0.data()["salesDate"] as? String }
                    
                    self.reviewItems = querySnapshot!.documents.compactMap { $0.data()["reviewAverage"] as? String }
                    
                    
                    self.collectionItem = document.data()
                    
                }
                    

                          // コレクションビューを更新
                self.movilogColleciton.reloadData()
                    
                    
                }
            
            
//            映画仲間の数を取得
            
            db.collection("users").document(user!.uid).collection("userFollowing").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
    
                        
                        self.friendCount = querySnapshot!.documents.compactMap { $0.data()["followUserID"] as? String }
                        
                        print(self.friendCount.count)
                        self.movieFriend.setTitle("映画仲間：\(self.friendCount.count)人", for: .normal)
 
                        }
                    }
                }
              
            
            
            }
    
        
        
        
        
        if let user = Auth.auth().currentUser {
//        ユーザーアイコンの取得
            let storageref = Storage.storage().reference(forURL: "gs://movi-log.appspot.com/").child("images").child(user.uid).child("\(user.uid).jpg")

        userImage.sd_setImage(with:storageref)
        
//        print("my icon is url\(storageref)")
        
        
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        
        self.imageData = imageItems[indexPath.row]
            
        cell.collectionImage.sd_setImage(with: URL(string:imageData), placeholderImage: UIImage(named: "placeholder.png"))

        return cell
                
    }
    
  
    
    // Cell が選択された場合
      func collectionView(_ collectionView: UICollectionView,
                            didSelectItemAt indexPath: IndexPath) {
   
        self.imageData = imageItems[indexPath.row]
        self.titleData = titleItems[indexPath.row]
        self.artistData = artistItems[indexPath.row]
        self.saleDateData = saleDataItems[indexPath.row]
        self.reviewData = reviewItems[indexPath.row]
        
          performSegue(withIdentifier: "collectionDetail",sender: nil)
   
      }
   
      // Segue 準備
      override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
          if (segue.identifier == "collectionDetail") {
              let subVC: movieCollectionDetail = (segue.destination as? movieCollectionDetail)!
              // SubViewController のselectedImgに選択された画像を設定する
            subVC.selectedImage = imageData
            subVC.selectedTitle = titleData
            subVC.selectedArtist = artistData
            subVC.selectedSaleDate = saleDateData
            subVC.selectedReviewAverage = reviewData
            
          }
      }
    

    
    
    

}
    



