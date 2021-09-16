//
//  searchFriends.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/10.
//

import UIKit
import Firebase


//    var fuid = ""


class searchFriends: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    
    private let cellId = "cellId"
    private var friends: [String] = []
    private var friendsId: [String] = []
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
                    
//                    usernameを取得
                    self.friendsId = querySnapshot!.documents.compactMap { $0.data()["userID"] as? String}
                
                    
                }
                    

                // コレクションビューを更新
                self.searchFriendTableView.reloadData()
                    
                    
            }
            
            
        }
            

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! searchFriendsTableViewCell
        
        cell.friendsLabel?.text = friends[indexPath.row]
        
        self.followID = friendsId[indexPath.row]
        
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
    
//    @IBAction func followTapped(_ sender: Any) {
//
//        let db = Firestore.firestore()
//
//           let user = Auth.auth().currentUser
//
//           db.collection("following").document(user!.uid).collection("userFollowing").document(
//               followID).setData([
//               "follow": true
//
//           ]) { err in
//               if let err = err {
//                   print("Error writing document: \(err)")
//               } else {
//                   print("Document successfully written!")
//
//           }
//
//       }
//
//    }
    
    
    
}








//func follow() {
//
//    let db = Firestore.firestore()
//
//    let user = Auth.auth().currentUser
//
//    db.collection("following").document(user!.uid).collection("userFollowing").document(
//        followID).setData([
//        "follow": true
//
//    ]) { err in
//        if let err = err {
//            print("Error writing document: \(err)")
//        } else {
//            print("Document successfully written!")
//
//    }
//
//}
//    }
