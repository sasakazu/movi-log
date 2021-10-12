//
//  movieFriendTableView.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/30.
//

import UIKit
import Firebase

class movieFriendTableView: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
//    cellID
    private let cellId = "cellId"

//    followingInfo
    var followingFriendID = ""
    var followingFriendsName: [String] = []
    var followingFriendsImage: [String] = []
    var myfollowingID: [String] = []
    
    var imageData = ""
    
    @IBOutlet weak var movieFTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieFTableview.register(UINib(nibName: "movieFTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        movieFTableview.delegate = self
        movieFTableview.dataSource = self

        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
//        useridを取得
        db.collection("users").document(user!.uid).collection("userFollowing").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                    self.myfollowingID = querySnapshot!.documents.compactMap { $0.data()["followUserID"] as? String}
                    
//                    print(self.myfollowingID)
                    
                    db.collection("users").whereField("userID", in: self.myfollowingID).getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                
                    self.followingFriendsName = querySnapshot!.documents.compactMap { $0.data()["nickname"] as? String}
//
                    self.followingFriendsImage = querySnapshot!.documents.compactMap { $0.data()["userIcon"] as? String}
            }
                        }
                        
                        
                        self.movieFTableview.reloadData()
                
                    }
            }


            }
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followingFriendsName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! movieFTableViewCell
        
        cell.movieFLabel.text = followingFriendsName[indexPath.row]
        
        self.imageData = followingFriendsImage[indexPath.row]
            
        cell.movieFImage.sd_setImage(with: URL(string:imageData), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        return cell
        
    }

    
    
    
}
