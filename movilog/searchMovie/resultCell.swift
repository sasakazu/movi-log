//
//  resultCell.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/01.
//

import UIKit
import Firebase
import SwiftUI

class resultCell: UITableViewCell {

    
//    user情報
    var userName = ""
    var userIcon = ""
    
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var directedTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
 
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        
        db.collection("users").document(user!.uid).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
                
                self.userName = document.data()?["nickname"] as! String
                self.userIcon = document.data()?["userIcon"] as! String
                
                
                
//                print(self.userName)
                
            } else {
                print("Document does not exist")
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var recip: SerchBookKList.ItemDic.ItemInfo? {
            didSet {
                resultTitle.text = recip?.title
                directedTitle.text = recip?.artistName
//                directedTitle.text = recip.dis
                let url = URL(string: recip?.largeImageUrl ?? "")
                do {
                    let data = try Data(contentsOf: url!)
                    let image = UIImage(data: data)
                    movieImage.image = image
                }catch let err {
                    print("Error : \(err.localizedDescription)")
                }
            }
    }
    
    
//    var test:String = ""
    
    @IBAction func collectionAdd(_ sender: Any) {
    
      
//        print("tatagataga\(button.tag)")
        
//
//        test = recip?.title ?? "dd"
//
//        print(test)
//        let db = Firestore.firestore()
//
//        let user = Auth.auth().currentUser
//
//        db.collection("users").document(user!.uid).collection("post").addDocument(data:[
//            "title": recip?.title ?? "",
//            "largeImageUrl": recip?.largeImageUrl ?? "",
//            "artistName": recip?.artistName ?? "",
//            "salesDate": recip?.salesDate ?? "",
//            "reviewAverage": recip?.reviewAverage ?? "",
//            "tag": "観たい"
//
//        ])
//
//        db.collection("allPosts").addDocument(data:[
//            "title": recip?.title ?? "",
//            "largeImageUrl": recip?.largeImageUrl ?? "",
//            "artistName": recip?.artistName ?? "",
//            "salesDate": recip?.salesDate ?? "",
//            "reviewAverage": recip?.reviewAverage ?? "",
//            "userID": user?.uid ?? "",
//            "nickName" :self.userName,
//            "userIcon": self.userIcon,
//            "tag": "観たい"
//
//            ]) { err in
//                if let err = err {
//                    print("Error writing document: \(err)")
//                } else {
//                    print("Document successfully written!")
//
//            }
//    }
//        
        
        
        
        
//    }
    
    }
    
    
    @IBAction func watchDone(_ sender: Any) {
        
      
//        let db = Firestore.firestore()
//
//        let user = Auth.auth().currentUser
//
//        db.collection("users").document(user!.uid).collection("post").addDocument(data:[
//            "title": recip?.title ?? "",
//            "largeImageUrl": recip?.largeImageUrl ?? "",
//            "artistName": recip?.artistName ?? "",
//            "salesDate": recip?.salesDate ?? "",
//            "reviewAverage": recip?.reviewAverage ?? "",
//            "tag": "見おわった"
//
//        ])
//
//        db.collection("allPosts").addDocument(data:[
//            "title": recip?.title ?? "",
//            "largeImageUrl": recip?.largeImageUrl ?? "",
//            "artistName": recip?.artistName ?? "",
//            "salesDate": recip?.salesDate ?? "",
//            "reviewAverage": recip?.reviewAverage ?? "",
//            "userID": user?.uid ?? "",
//            "nickName" :self.userName,
//            "userIcon": self.userIcon,
//            "tag": "観おわった"
//
//            ]) { err in
//                if let err = err {
//                    print("Error writing document: \(err)")
//                } else {
//                    print("Document successfully written!")
//
//            }
//    }
        
    }
    
    @IBAction func myBest(_ sender: Any) {
        
        let db = Firestore.firestore()

        let user = Auth.auth().currentUser

        db.collection("users").document(user!.uid).collection("post").addDocument(data:[
            "title": recip?.title ?? "",
            "largeImageUrl": recip?.largeImageUrl ?? "",
            "artistName": recip?.artistName ?? "",
            "salesDate": recip?.salesDate ?? "",
            "reviewAverage": recip?.reviewAverage ?? "",
            "tag": "マイベスト"

        ])

        db.collection("allPosts").addDocument(data:[
            "title": recip?.title ?? "",
            "largeImageUrl": recip?.largeImageUrl ?? "",
            "artistName": recip?.artistName ?? "",
            "salesDate": recip?.salesDate ?? "",
            "reviewAverage": recip?.reviewAverage ?? "",
            "userID": user?.uid ?? "",
            "nickName" :self.userName,
            "userIcon": self.userIcon,
            "tag": "マイベスト"

            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")

            }
    }
        
    }

    
}
