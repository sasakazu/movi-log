//
//  movieCollectionDetail.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/08.
//

import UIKit
import Firebase

class movieCollectionDetail: UIViewController {

//
    var documentid:String = ""
    var someComment:String = ""
    
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
    
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ID→\(documentid)")

        movieTitle.text = selectedTitle
        artist.text = selectedArtist
        saleDate.text = selectedSaleDate
        averageLabel.setTitle(selectedReviewAverage, for: .normal)
        
        print("ddddd\(selectedAffili)")
        
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

        let docRef = db.collection("users").document(user!.uid).collection("post").document(documentid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                
                self.someComment = document.data()?["comment"] as! String
//
                self.commentLabel.text = self.someComment
                
//                print(self.someComment)
//                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
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
    


}
