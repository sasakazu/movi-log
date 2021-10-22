//
//  halfModalViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/20.
//

import UIKit
import Firebase

class halfModalViewController: UIViewController {

//    映画変数
    var halfTitle:String = ""
    var artist:String = ""
    var imageUrl:String = ""
    var review:String = ""
    var sales:String = ""
    
//    user情報
    var username:String = ""
    var userid:String = ""
    var userimage:String = ""
  
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let user = Auth.auth().currentUser
        
        let db = Firestore.firestore()
        //        ユーザー情報を取得
            let docRef = db.collection("users").document(user!.uid)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
        //                print("Document data: \(dataDescription)")
                        
                    self.username = document["nickname"] as? String ?? "no name"
                    self.userid = document["userID"] as? String ?? "no name"
                    self.userimage = document["userIcon"] as? String ?? "no name"
         
                        
                    } else {
                        print("Document does not exist")
                    }
                
                
//                label.text = self.halfTitle
            }
                
                print(halfTitle)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        
        
                let db = Firestore.firestore()
        
                let user = Auth.auth().currentUser
        
                db.collection("users").document(user!.uid).collection("post").addDocument(data:[
                    "title": halfTitle,
                    "largeImageUrl": imageUrl,
                    "artistName": artist,
                    "salesDate": sales,
                    "reviewAverage": review,
                    "tag": "観たい"
        
                ])
        
                db.collection("allPosts").addDocument(data:[
                    "title": halfTitle,
                    "largeImageUrl": imageUrl,
                    "artistName": artist,
                    "salesDate": sales,
                    "reviewAverage": review,
                    "userID": user?.uid ?? "",
                    "nickName" :self.username,
                    "userIcon": self.userimage,
                    "tag": "観たい"
        
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
        
                    }
            }
        
        dismiss(animated: true, completion: nil)
        
    }
    

    @IBAction func watchedBtn(_ sender: Any) {
        
                let db = Firestore.firestore()
        
                let user = Auth.auth().currentUser
        
                db.collection("users").document(user!.uid).collection("post").addDocument(data:[
                    "title": halfTitle,
                    "largeImageUrl": imageUrl,
                    "artistName": artist,
                    "salesDate": sales,
                    "reviewAverage": review,
                    "tag": "観た"
        
                ])
        
                db.collection("allPosts").addDocument(data:[
                    "title": halfTitle,
                    "largeImageUrl": imageUrl,
                    "artistName": artist,
                    "salesDate": sales,
                    "reviewAverage": review,
                    "userID": user?.uid ?? "",
                    "nickName" :self.username,
                    "userIcon": self.userimage,
                    "tag": "観た"
        
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
        
                    }
            }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func myBestBtn(_ sender: Any) {
        
            let db = Firestore.firestore()
        
            let user = Auth.auth().currentUser
        
            db.collection("users").document(user!.uid).collection("post").addDocument(data:[
                    "title": halfTitle,
                    "largeImageUrl": imageUrl,
                    "artistName": artist,
                    "salesDate": sales,
                    "reviewAverage": review,
                    "tag": "マイベスト"
        
            ])
        
            db.collection("allPosts").addDocument(data:[
                    "title": halfTitle,
                    "largeImageUrl": imageUrl,
                    "artistName": artist,
                    "salesDate": sales,
                    "reviewAverage": review,
                    "userID": user?.uid ?? "",
                    "nickName" :self.username,
                    "userIcon": self.userimage,
                    "tag": "マイベスト"
        
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
        
                }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
