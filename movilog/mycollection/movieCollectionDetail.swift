//
//  movieCollectionDetail.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/08.
//

import UIKit
import Firebase
import SDWebImage

class movieCollectionDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let cellId = "cellId"

//    section
    let sectionTitles = ["自分のコメント","みんなのコメント"]
    
//    user情報
    var username:String = ""
    var userImage:String = ""
    var postdate:String = ""
    
//      自分のコメント用
    var documentid:String = ""
    var myComment:[String] = []
    
    var selectedTitle:String = ""
    var selectedImage:String = ""
    var selectedArtist:String = ""
    var selectedSaleDate:String = ""
    var selectedReviewAverage:String = ""
    var selectedAffili:String = ""
    var selectedJancode:String = ""
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var companyLabe: UILabel!
    @IBOutlet weak var saleDate: UILabel!
    @IBOutlet weak var averageLabel: UIButton!
    
    @IBOutlet weak var commentTable: UITableView!
    
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentTable.dataSource = self
        self.commentTable.dataSource = self
        
        commentTable.register(UINib(nibName: "commentTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        
//        print("ID→\(documentid)")

        movieTitle.text = selectedTitle
        artist.text = selectedArtist
        saleDate.text = selectedSaleDate
        averageLabel.setTitle(selectedReviewAverage, for: .normal)
        
//        print("ddddd\(selectedAffili)")
        
        //        画像表示
        let url = URL(string: selectedImage)
            do {
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                selectedImageView.image = image
                    
                }catch let err {
                    print("Error : \(err.localizedDescription)")
            }
        
        
        
//        documentIDからを取得する
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        
//        user情報取得
        let docRef = db.collection("users").document(user!.uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
                
                self.username = document["nickname"] as? String ?? "no name"
                self.userImage = document["userIcon"] as? String ?? "no name"
                
                
            } else {
                print("Document does not exist")
            }
            
            self.commentTable.reloadData()
        }
        
        
        let Ref = db.collection("users").document(user!.uid)
//        post comment取得
        Ref.collection("post").whereField("documentID", isEqualTo: documentid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
    
//                                映画情報
                    self.myComment = querySnapshot!.documents.compactMap { $0.data()["comment"] as? String
        
        
//
//                self.commentLabel.text = self.someComment
                
//                print(self.someComment)
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//
              
            }
            
                }
                
                self.commentTable.reloadData()
            }
        }
        
        
//        みんなのコメントをjancodeで取得する
        
        print(selectedJancode)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func goRakuten(_ sender: Any) {
        
        let url = NSURL(string: "\(selectedAffili)")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
        
    }
    
    
    @IBAction func writeComment(_ sender: Any) {
        
        
        performSegue(withIdentifier: "goComment",sender: nil)
        
        
    }
    
    
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
       
        let subVC: comment = (segue.destination as? comment)!
          
        subVC.documentID = documentid
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        自分のコメント
        if section == 0{
            
                return myComment.count
            
        }else if section == 1 {
                return 0
        
        }else{
                return 0
            }

      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print(myComment)
        print(username)
        print(userImage)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! commentTableViewCell
        
        cell.username.text = username
        cell.commentText.text = myComment[indexPath.row]
       
        
//        cell.userIcon.sd_setImage(with: URL(string:userImage), placeholderImage: UIImage(named: "placeholder"))
        
        
        let url = URL(string: userImage)
            do {
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                cell.userIcon.image = image

            }catch let err {
                print("Error : \(err.localizedDescription)")
            }
        
        return cell
        
    }
    
    
//    section setting
    
    func numberOfSections(in tableView: UITableView) -> Int {
           //セクションの数
           return 2
       }
       
       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           //セクションのタイトルを設定する。
           return sectionTitles[section]
       }
    
    
    
}
