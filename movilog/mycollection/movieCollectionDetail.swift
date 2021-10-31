//
//  movieCollectionDetail.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/08.
//

import UIKit
import Firebase

class movieCollectionDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let cellId = "cellId"

//      自分のコメント用
    var documentid:String = ""
    var myComment:[String] = []
    
    var selectedTitle:String = ""
    var selectedImage:String = ""
    var selectedArtist:String = ""
    var selectedSaleDate:String = ""
    var selectedReviewAverage:String = ""
    var selectedAffili:String = ""

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

        let docRef = db.collection("users").document(user!.uid).collection("post").whereField("documentID", isEqualTo: documentid).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
    
//                                映画情報
                    self.myComment = querySnapshot!.documents.compactMap { $0.data()["comment"] as! String
        
        
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
        
        return myComment.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print(myComment)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! commentTableViewCell
        

        cell.commentText.text = myComment[indexPath.row]
        
        return cell
        
    }
    
    
}
