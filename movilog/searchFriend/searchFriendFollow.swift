//
//  searchFriendFollow.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/08.
//

import UIKit
import Firebase
import SDWebImage

class searchFriendFollow: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//followinguser
    var followingID = ""
    var followingFriends: [String] = []
    var followingFriendsIcon: [String] = []
    var myfollowingID: [String] = []
    var imageData = ""
    
    private let cellId = "cellId"
    
    @IBOutlet weak var followingTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        followingTableview.delegate = self
        followingTableview.dataSource = self
        
        followingTableview.register(UINib(nibName: "searchFriendFollowingCell", bundle: nil), forCellReuseIdentifier: cellId)
        
//        print(followingID)

        let db = Firestore.firestore()
        
//        useridを取得
        db.collection("users").document(followingID).collection("userFollowing").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                    
                    
                    self.myfollowingID = querySnapshot!.documents.compactMap { $0.data()["followUserID"] as? String}
                    
                    print(self.myfollowingID)
                    
                    db.collection("users").whereField("userID", in: self.myfollowingID).getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                

                    
                    self.followingFriends = querySnapshot!.documents.compactMap { $0.data()["nickname"] as? String}
//
                    self.followingFriendsIcon = querySnapshot!.documents.compactMap { $0.data()["userIcon"] as? String}
            }
                        }
                        
                        
                        self.followingTableview.reloadData()
                    }
                    }
//                followしているユーザー情報を取得
        
                

            }
        }
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return followingFriends.count
        
        print(followingFriends.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! searchFriendFollowingCell
        
        cell.followingLabel?.text = followingFriends[indexPath.row]
        
        self.imageData = followingFriendsIcon[indexPath.row]
            
        cell.followingIcon.sd_setImage(with: URL(string:imageData), placeholderImage: UIImage(named: "placeholder.png"))

        
        return cell
        
    }
    
    
}
