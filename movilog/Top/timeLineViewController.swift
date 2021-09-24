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
    
//    followしたポストを代入する配列
//    映画情報
    private var allTitle :[String] = []
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
    

        
        db.collection("users").document(user!.uid).collection("userFollowing").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                
                if let err = err {
                               print("\(err)")
                           } else {
                               for document in querySnapshot!.documents {
                                
                                self.allTitle += document.data()["movieTitle"] as! [String]
                                self.artistArray += document.data()["artistName"] as! [String]

                                self.followImageArray += document.data()["followImage"] as! [String]
                                
                                
                                print(allTitle)
                                
                                
                               }
                                
                            self.TLtableview.reloadData()
        

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
        
        cell.TLMovieTitle?.text = allTitle[indexPath.row]
        cell.artistLable.text = artistArray[indexPath.row]
        
        let url = URL(string: followImageArray[indexPath.row])
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            cell.movieImage.image = image
            
        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
        
//        print(followid.count)
    
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    
       
        }
    
    
    
        
      
    }
 


