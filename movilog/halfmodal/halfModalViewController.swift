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
    var documentId: String = ""
    var affiliUrl:String = ""
    
//    user情報
    var username:String = ""
    var userid:String = ""
    var userimage:String = ""
  
    var postDate:String = ""
    
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
        
        
        
//        投稿日時を取得したい
        // 日時に変換したい文字列を準備
//        let dtStr = "2019/06/19 12:30:20"
//
//        // DateFormatter のインスタンスを作成
//        let formatter: DateFormatter = DateFormatter()
//
//        // 日付の書式を文字列に合わせて設定
//        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
//
//        formatter.dateStyle = .short
//
//        // 日時文字列からDate型の日付を生成する
//        let dt : Date  = formatter.date(from: dtStr)!
//
//
//
//        // 作成した日付を表示してみる
//        print(formatter.string(from: dt))

        // 日付型の値を直接表示してみる
//        print(dt)
        
        
        // 現在日時を dt に代入
        let dt = Date()
        // DateFormatter のインスタンスを作成
        let formatter: DateFormatter = DateFormatter()

        // ロケールを日本（日本語）に設定
        formatter.locale = Locale(identifier: "ja_JP")
        
        formatter.dateStyle = .short
//        print(formatter.string(from: dt))
        
        postDate = formatter.string(from: dt)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
        let testRef = db.collection("users").document(user!.uid).collection("post")
        
        let postRef = db.collection("allPosts")
        
        let aDoc = testRef.document()
        
        print(aDoc.documentID)
        
        let someData = ["title": halfTitle,
                        "largeImageUrl": imageUrl,
                        "artistName": artist,
                        "salesDate": sales,
                        "reviewAverage": review,
                        "postDate": postDate,
                        "affiliUrl": affiliUrl,
                        "documentID": aDoc.documentID,
                        "tag": "観たい"] as [String : Any]
        
        
        let postData = ["title": halfTitle,
                        "largeImageUrl": imageUrl,
                        "artistName": artist,
                        "salesDate": sales,
                        "reviewAverage": review,
                        "postDate": postDate,
                        "affiliUrl": affiliUrl,
                        "documentID": aDoc.documentID,
                        "tag": "観たい",
                        "userID": user?.uid ?? "",
                        "nickName" :self.username,
                        "userIcon": self.userimage] as [String : Any]
        
        
        testRef.document(aDoc.documentID).setData(someData)
        postRef.addDocument(data: postData)
        
        dismiss(animated: true, completion: nil)
        
        
    }
    

    @IBAction func watchedBtn(_ sender: Any) {
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
        let testRef = db.collection("users").document(user!.uid).collection("post")
        
        let postRef = db.collection("allPosts")
        
        let aDoc = testRef.document()
        
        print(aDoc.documentID)
        
        let someData = ["title": halfTitle,
                        "largeImageUrl": imageUrl,
                        "artistName": artist,
                        "salesDate": sales,
                        "reviewAverage": review,
                        "postDate": postDate,
                        "affiliUrl": affiliUrl,
                        "documentID": aDoc.documentID,
                        "tag": "観た"] as [String : Any]
        
        
        let postData = ["title": halfTitle,
                        "largeImageUrl": imageUrl,
                        "artistName": artist,
                        "salesDate": sales,
                        "reviewAverage": review,
                        "postDate": postDate,
                        "affiliUrl": affiliUrl,
                        "documentID": aDoc.documentID,
                        "tag": "観た",
                        "userID": user?.uid ?? "",
                        "nickName" :self.username,
                        "userIcon": self.userimage] as [String : Any]
        
        
        testRef.document(aDoc.documentID).setData(someData)
        postRef.addDocument(data: postData)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func myBestBtn(_ sender: Any) {
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
        let testRef = db.collection("users").document(user!.uid).collection("post")
        
        let postRef = db.collection("allPosts")
        
        let aDoc = testRef.document()
        
        print(aDoc.documentID)
        
        let someData = ["title": halfTitle,
                        "largeImageUrl": imageUrl,
                        "artistName": artist,
                        "salesDate": sales,
                        "reviewAverage": review,
                        "postDate": postDate,
                        "affiliUrl": affiliUrl,
                        "documentID": aDoc.documentID,
                        "tag": "マイベスト"] as [String : Any]
        
        
        let postData = ["title": halfTitle,
                        "largeImageUrl": imageUrl,
                        "artistName": artist,
                        "salesDate": sales,
                        "reviewAverage": review,
                        "postDate": postDate,
                        "affiliUrl": affiliUrl,
                        "documentID": aDoc.documentID,
                        "tag": "マイベスト",
                        "userID": user?.uid ?? "",
                        "nickName" :self.username,
                        "userIcon": self.userimage] as [String : Any]
        
        
        testRef.document(aDoc.documentID).setData(someData)
        postRef.addDocument(data: postData)
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
