//
//  searchFriends.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/10.
//

import UIKit
import Firebase


class searchFriends: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    
    private let cellId = "cellId"
    
//    friend情報
    private var friends: [String] = []
    private var friendsId: [String] = []
    private var friendsIcon: [String] = []
    var followID = ""
    
    @IBOutlet weak var searchFriendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        searchFriendTableView.register(UINib(nibName: "searchFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        searchFriendTableView.delegate = self
        searchFriendTableView.dataSource = self
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

                    
//                    print("\(document.documentID) => \(String(describing: document.data()))")

//                    usernameを取得
                    self.friends = querySnapshot!.documents.compactMap { $0.data()["nickname"] as? String}
                    
                    self.friendsIcon = querySnapshot!.documents.compactMap { $0.data()["userIcon"] as? String}
                    
//                    print(self.friends)
//                    useridを取得
                    self.friendsId = querySnapshot!.documents.compactMap { $0.data()["userID"] as? String}
                
                    print(self.friends)
                    
                }
                    

                // コレクションビューを更新
                self.searchFriendTableView.reloadData()
                    
                    
            }
            
            
        }
            

    }
    
//    //    セルの高さ
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//               return 100
//           }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! searchFriendsTableViewCell
        
        cell.friendsLabel?.text = friends[indexPath.row]
        
        self.followID = friendsId[indexPath.row]
        
        //        ユーザーアイコン
        let url = URL(string: friendsIcon[indexPath.row])
            do {
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                cell.friendIconView.image = image

            }catch let err {
                print("Error : \(err.localizedDescription)")
            }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        followID = friendsId[indexPath.row]
        print(followID)
        performSegue(withIdentifier: "sendID", sender: nil)
        
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "sendID" {
            if let nextVC = segue.destination as? friendDetaiView {
              
            nextVC.friendUserID = followID
            
                
            
        }
    }
}
    

    
    
    
}








