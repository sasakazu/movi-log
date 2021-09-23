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
    private var followid: [String] = []
    
    private var timeLineLabel: [String] = []
    
//    followしたポストを代入する配列
    var all :[String] = []
    
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
    

        
        db.collection("users").document(user!.uid).collection("userFollowing").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                
                if let err = err {
                               print("\(err)")
                           } else {
                               for document in querySnapshot!.documents {
                                
                                self.followid = document.data()["nickname"] as! [String]

//                                配列に配列を代入する
                                self.all += followid
                                
                                print(all)
                                
                                
                               }
                                
                            self.TLtableview.reloadData()
        

                           }
                
                
                    }
                    
                }

        }
    
                   
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return all.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TLTableViewCell
        
        cell.TLMovieTitle?.text = all[indexPath.row]
        
        print(followid.count)
    
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    
       
        }
    
    
    
        
      
    }
 


