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

    
    private var titledata: [String] = []
    private var imageItems: [String] = []
    var imageData = ""
    
    @IBOutlet weak var username: UIButton!
    @IBOutlet weak var movilogColleciton: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        if let user = user {
    
            let email = user.email! as String

            //ボタンにユーザーネームの表示
            username.setTitle("\(email) >", for: UIControl.State.normal)
            
        }
    
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.movilogColleciton.register(nib, forCellWithReuseIdentifier: "Cell")
        
        let db = Firestore.firestore()
        
        db.collection("users").document(user!.uid).collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                    
                    print("\(document.documentID) => \(String(describing: document.data()["title"]))")

//                    titleを取得
                    self.titledata = querySnapshot!.documents.compactMap { $0.data()["title"] as? String }
                    
                    self.imageItems = querySnapshot!.documents.compactMap { $0.data()["largeImageUrl"] as? String }
                    
                    print(self.imageItems)
                    
//
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
    

    
    
    


}
