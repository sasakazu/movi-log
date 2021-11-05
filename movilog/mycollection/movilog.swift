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

class movilog: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var viewTable: [String] = []
    
    
//    let imageArr = [
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!,
//        UIImage(named: "a")!
//    ]
    
//    全部の映画タグ
    private var titleItems: [String] = []
    private var imageItems: [String] = []
    private var artistItems: [String] = []
    private var saleDataItems: [String] = []
    private var reviewItems: [String] = []
    private var affiliItems: [String] = []
    private var documentidItems: [String] = []
    
//    観たい映画タグ
    private var watchTitles: [String] = []
    private var watchImages: [String] = []
    private var watchArtists: [String] = []
    private var watchSaleDatas: [String] = []
    private var watchReviews: [String] = []
    private var watchAffili: [String] = []
    private var watchDocumentid: [String] = []
    
    
//    マイベスト映画タグ
    private var bestTitles: [String] = []
    private var bestImages: [String] = []
    private var bestArtists: [String] = []
    private var bestSaleDatas: [String] = []
    private var bestReviews: [String] = []
    private var bestAffilis: [String] = []
    private var bestDocumentid: [String] = []
    
//    全映画情報
    var collectionItem: [String:Any] = [:]
    var imageData = ""
    var titleData = ""
    var artistData = ""
    var saleDateData = ""
    var reviewData = ""
    var affiliData = ""
    var documentidData = ""
    
//    観たい映画情報
    var watchItems: [String:Any] = [:]
    var watchImageData = ""
    var watchTitleData = ""
    var watchArtistData = ""
    var watchSaleDateData = ""
    var watchReviewData = ""
    var watchAffiliData = ""
    var watchDocumentidData = ""
    
//    マイベスト映画情報
    var myBestItems: [String:Any] = [:]
    var myBestImageData = ""
    var myBestTitleData = ""
    var myBestArtistData = ""
    var myBestSaleDateData = ""
    var myBestReviewData = ""
    var myBestAffiliData = ""
    var myBestDocumentidData = ""
    
//    ユーザー情報
    var nickname = ""
    var friendCount:[String] = []
    
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var movilogColleciton: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var movieFriend: UIButton!
    @IBOutlet weak var changeTag: UISegmentedControl!
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        

        collectionHeight.constant = movilogColleciton.contentSize.height
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        viewTable = imageItems

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
        
//        全てのpostを取得
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
                    self.affiliItems = querySnapshot!.documents.compactMap { $0.data()["affiliUrl"] as? String }
                    self.documentidItems = querySnapshot!.documents.compactMap { $0.data()["documentID"] as? String }
                    
                    
                    self.collectionItem = document.data()
                    
//                    self.movilogColleciton.reloadData()
                    
                }
                    

                          // コレクションビューを更新
                
                    
                    
                }
            
            
//            観たいタグ映画を取得
            
            db.collection("users").document(user!.uid).collection("post").whereField("tag", isEqualTo: "観たい").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
            
//                                映画情報
                    self.watchTitles = querySnapshot!.documents.compactMap { $0.data()["title"] as? String}
                    self.watchImages = querySnapshot!.documents.compactMap { $0.data()["largeImageUrl"] as? String }
                            
                    self.watchArtists = querySnapshot!.documents.compactMap { $0.data()["artistName"] as? String }
                          
                    self.watchSaleDatas = querySnapshot!.documents.compactMap { $0.data()["salesDate"] as? String }
                            
                    self.watchReviews = querySnapshot!.documents.compactMap { $0.data()["reviewAverage"] as? String }
                    self.watchAffili = querySnapshot!.documents.compactMap { $0.data()["affiliUrl"] as? String }
                            
                    self.watchDocumentid = querySnapshot!.documents.compactMap { $0.data()["documentID"] as? String }
                    
//                  print("観たいcount\(self.watchTitles.count)")
                   
                        
                        }
                        
                        
                    }
                
                
//                self.movilogColleciton.reloadData()
                
            }
//            マイベスト映画を取得
            
            db.collection("users").document(user!.uid).collection("post").whereField("tag", isEqualTo: "マイベスト").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
            
//                                映画情報
                    self.bestTitles = querySnapshot!.documents.compactMap { $0.data()["title"] as? String}
                    self.bestImages = querySnapshot!.documents.compactMap { $0.data()["largeImageUrl"] as? String }
                            
                    self.bestArtists = querySnapshot!.documents.compactMap { $0.data()["artistName"] as? String }
                          
                    self.bestSaleDatas = querySnapshot!.documents.compactMap { $0.data()["salesDate"] as? String }
                            
                    self.bestReviews = querySnapshot!.documents.compactMap { $0.data()["reviewAverage"] as? String }
                    self.bestAffilis = querySnapshot!.documents.compactMap { $0.data()["affiliUrl"] as? String }
                    self.bestDocumentid = querySnapshot!.documents.compactMap { $0.data()["documentID"] as? String }
                    
//                  print("観たいcount\(self.watchTitles.count)")
                   
                        
                        }
                        
                        
                    }
                
                
//                self.movilogColleciton.reloadData()
                
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
              
            
       
        self.movilogColleciton.reloadData()

        
        
        
        
        
        if let user = Auth.auth().currentUser {
//        ユーザーアイコンの取得
            let storageref = Storage.storage().reference(forURL: "gs://movi-log.appspot.com/").child("images").child(user.uid).child("\(user.uid).jpg")
        
            self.userImage.sd_setImage(with: storageref, placeholderImage: UIImage(named: "placeholder2"))
            
//        print("my icon is url\(storageref)")
        
        
            self.userImage.layer.cornerRadius = self.userImage.frame.size.width * 0.5
            self.userImage.clipsToBounds = true
            
        }
        
        
        movilogColleciton.reloadData()
        
    }
    


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewTable.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        self.imageData = viewTable[indexPath.row]
            
        cell.collectionImage.sd_setImage(with: URL(string:imageData), placeholderImage: UIImage(named: "placeholder"))
        
//        cell.collectionImage.image = imageArr[indexPath.row]
        
        return cell
                
    }
    
  
    
    // Cell が選択された場合
      func collectionView(_ collectionView: UICollectionView,
                            didSelectItemAt indexPath: IndexPath) {
        
        if changeTag.selectedSegmentIndex == 0 {
               // value for first index selected here
           
//          全ポスト
        self.imageData = imageItems[indexPath.row]
        self.titleData = titleItems[indexPath.row]
        self.artistData = artistItems[indexPath.row]
        self.saleDateData = saleDataItems[indexPath.row]
        self.reviewData = reviewItems[indexPath.row]
        self.affiliData = affiliItems[indexPath.row]
        self.documentidData = documentidItems[indexPath.row]
          
          } else if changeTag.selectedSegmentIndex == 1 {
              
          
////          観たいポスト
        self.watchImageData = watchImages[indexPath.row]
        self.watchTitleData = watchTitles[indexPath.row]
        self.watchArtistData = watchArtists[indexPath.row]
        self.watchSaleDateData = watchSaleDatas[indexPath.row]
        self.watchReviewData = watchReviews[indexPath.row]
        self.watchAffiliData = watchAffili[indexPath.row]
        self.watchDocumentidData = watchDocumentid[indexPath.row]
          
          }
          
        else if changeTag.selectedSegmentIndex == 2{
   
////          マイベストポスト
        self.myBestImageData = bestImages[indexPath.row]
        self.myBestTitleData = bestTitles[indexPath.row]
        self.myBestArtistData = bestArtists[indexPath.row]
        self.myBestSaleDateData = bestSaleDatas[indexPath.row]
        self.myBestReviewData = bestReviews[indexPath.row]
        self.myBestAffiliData = bestAffilis[indexPath.row]
        self.myBestDocumentidData = bestDocumentid[indexPath.row]
        
        
        }
          
        performSegue(withIdentifier: "collectionDetail",sender: nil)
   
      }
   
      // Segue 準備
      override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
          if (segue.identifier == "collectionDetail") {
              let subVC: movieCollectionDetail = (segue.destination as? movieCollectionDetail)!
              // SubViewController のselectedImgに選択された画像を設定する
            
            if changeTag.selectedSegmentIndex == 0 {
              
//              全て
            subVC.selectedImage = imageData
            subVC.selectedTitle = titleData
            subVC.selectedArtist = artistData
            subVC.selectedSaleDate = saleDateData
            subVC.selectedReviewAverage = reviewData
            subVC.selectedAffili = affiliData
            subVC.documentid = documentidData
              
              
          } else if changeTag.selectedSegmentIndex == 1 {
//              観たいタグ
            subVC.selectedImage = watchImageData
            subVC.selectedTitle = watchTitleData
            subVC.selectedArtist = watchArtistData
            subVC.selectedSaleDate = watchSaleDateData
            subVC.selectedReviewAverage = watchReviewData
            subVC.selectedAffili = watchAffiliData
            subVC.documentid = watchDocumentidData
              
          
          }
              
            else if changeTag.selectedSegmentIndex == 2{
//              マイベスト
            subVC.selectedImage = myBestImageData
            subVC.selectedTitle = myBestTitleData
            subVC.selectedArtist = myBestArtistData
            subVC.selectedSaleDate = myBestSaleDateData
            subVC.selectedReviewAverage = myBestReviewData
            subVC.selectedAffili = myBestAffiliData
            subVC.documentid = myBestDocumentidData
                
}
          }
              
              
          
      }
    

    @IBAction func changeTags(_ sender: UISegmentedControl) {
    
        
        
        switch sender.selectedSegmentIndex {
             case 0:viewTable = imageItems
             case 1:viewTable = watchImages
             case 2:viewTable = bestImages
             default:break

        }
        
        self.movilogColleciton.reloadData()
    }
    
    
    

}
    



