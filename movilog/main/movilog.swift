//
//  movilog.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/08/13.
//

import UIKit
import Firebase
import SDWebImage

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
    
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var movilogColleciton: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        db.collection("users").document(user!.uid).collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                    
//                    print("\(document.documentID) => \(String(describing: document.data()))")

//                    titleを取得
                    self.titleItems = querySnapshot!.documents.compactMap { $0.data()["title"] as? String }
                    
                    self.imageItems = querySnapshot!.documents.compactMap { $0.data()["largeImageUrl"] as? String }
                    
                    self.artistItems = querySnapshot!.documents.compactMap { $0.data()["artistName"] as? String }
                  
                    self.saleDataItems = querySnapshot!.documents.compactMap { $0.data()["salesDate"] as? String }
                    
                    self.reviewItems = querySnapshot!.documents.compactMap { $0.data()["reviewAverage"] as? String }
                    
                    
//                    print(self.saleDataItems)
                    
                    self.collectionItem = document.data()
                    
                }
                    

                          // コレクションビューを更新
                self.movilogColleciton.reloadData()
                    
                    
                }
            
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
    



