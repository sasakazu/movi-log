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
    private var followid = ""
    
    private var timeLineLabel: [String] = []
    
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
    
        
        
//        followingのIDを取得する
        db.collection("following").document(user!.uid).collection("userFollowing").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {

    
//                    print(document.data()["userID"])
                    
//                    usernameを取得
//                    self.getFollwingID = querySnapshot!.documents.compactMap { $0.data()["userID"] as? String}
                    
                    self.followid = document.data()["userID"] as! String
                    
//                    print(self.followid)

//                    let followdb = Firestore.firestore()
                    
                   
            //                    print(document.data()["userID"])
                                
            //                    usernameを取得
//                                self.getFollwingID = querySnapshot!.documents.compactMap { $0.data()["userID"] as? String}
                                
//                                print(self.getFollwingID)
                    
                    
                    
                    //        TLにフォローしたポストを表示させる
                            
                    db.collection("allPosts").whereField("userID", isEqualTo: self.followid)
                                .getDocuments() { (querySnapshot, err) in
                                    if let err = err {
                                        print("Error getting documents: \(err)")
                                    } else {
                                        for document in querySnapshot!.documents {

//                                            print("\(document.documentID) => \(document.data()["userID"])")

                                            self.FollwingPosts = querySnapshot!.documents.compactMap { $0.data() as? String}

                                            self.timeLineLabel = querySnapshot!.documents.compactMap { $0.data()["title"] as? String}
                                            
//                                            self.timeLineLabel = querySnapshot?.documents.
//                                            print(self.timeLineLabel)

//                                            print(self.timeLineLabel.count)

//                                            print(document.data()["title"])
                                        }
                                    }
//
//                    //            print(doc)
//                                }
                    
                                    self.TLtableview.reloadData()
//                    followid = getFollwingID
                }
                // コレクションビューを更新
                   
                    
            }
            
            
    
            
        }
        
        
////        TLにフォローしたポストを表示させる
//
//        db.collection("allPosts").whereField("userID", isEqualTo: getFollwingID)
//            .getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//
//                        print("\(document.documentID) => \(document.data())")
//
//                        print(document.data()["title"])
//                    }
//                }
//
////            print(doc)
            }
        
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return FollwingPosts.count
        
        return timeLineLabel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TLTableViewCell
        
        cell.TLMovieTitle?.text = timeLineLabel[indexPath.row]
        
     print(timeLineLabel)
    
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
         test = timeLineLabel[indexPath.row]
        
        print(test)
       
        }
    
    
    
        
      
    }
 


