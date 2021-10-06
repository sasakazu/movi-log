//
//  timeLineViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/17.
//

import UIKit
import Firebase

class timeLineViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    private let cellId = "cellId"
    
    private var FollwingPosts: [String] = []
    private var timeLineLabel: [String] = []
    private var followid: [String] = []
    
//    followUser情報
    private var followUserID:String = ""
    private var followUserIcon:[String] = []
    private var followUsername:[String] = []
    
//    followしたポストを代入する配列
//    映画情報
    private var allTitle:[String] = []
    private var movieImage:[String] = []
    private var artistArray: [String] = []
    private var followImageArray: [String] = []

    var test = ""
    
    @IBOutlet weak var TLtableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TLtableview.register(UINib(nibName: "TLTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        let user = Auth.auth().currentUser
        
        let email = user?.email
        
        print(email ?? "no user")

        TLtableview.delegate = self
        TLtableview.dataSource = self
        
        let db = Firestore.firestore()
    

//        フォローしたユーザーのIDを取得する
        
        db.collection("following").document(user!.uid).collection("followingUser").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    
                    self.followid = querySnapshot!.documents.compactMap { $0.data()["followID"] as? String }
                 
                    
                    print(self.followid)
        //        取得したIDからタイムラインを表示させる
        
                    db.collection("allPosts").whereField("userID", in: self.followid).getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                
//                                映画情報
                        self.allTitle = querySnapshot!.documents.compactMap { $0.data()["title"] as? String}
                        self.artistArray = querySnapshot!.documents.compactMap { $0.data()["artistName"] as? String}
                        self.movieImage = querySnapshot!.documents.compactMap { $0.data()["largeImageUrl"] as? String}
//                                ユーザー情報
                        self.followUsername = querySnapshot!.documents.compactMap { $0.data()["nickName"] as? String}
                        self.followUserIcon = querySnapshot!.documents.compactMap { $0.data()["userIcon"] as? String}
                        
                        
//                        print(self.allTitle)
//                    print("\(document.documentID) => \(document.data())")
                }
            }    
                        
                        self.TLtableview.reloadData()
                    
                    }
                    
                }
               
                
            }
            
        }

       
}

    
    //    セルの高さ
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 190
           }
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allTitle.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TLTableViewCell
        
//        post情報
        cell.TLMovieTitle?.text = allTitle[indexPath.row]
        cell.artistLable.text = artistArray[indexPath.row]

        
        let myurl = URL(string: movieImage[indexPath.row])
        do {
            let data = try Data(contentsOf: myurl!)
            let image = UIImage(data: data)
            cell.movieImage.image = image

        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
//        user情報
        cell.followAction.text = followUsername[indexPath.row]
//        ユーザーアイコン
        let url = URL(string: followUserIcon[indexPath.row])
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            cell.followIcon.image = image

        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    
       
        }
    
    
    
        
      
    }
 


