//
//  resultCell.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/01.
//

import UIKit
import Firebase

class resultCell: UITableViewCell {

    
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var directedTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var recip: SerchBookKList.ItemDic.ItemInfo? {
            didSet {
                resultTitle.text = recip?.title
                directedTitle.text = recip?.artistName
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
    
    
    @IBAction func collectionAdd(_ sender: Any) {
        
        let db = Firestore.firestore()
        
        let user = Auth.auth().currentUser
        
        db.collection("users").document(user!.uid).collection("posts").addDocument(data:[
            "title": recip?.title ?? "",
            "largeImageUrl": recip?.largeImageUrl ?? "",
            "artistName": recip?.artistName ?? "",
            "salesDate": recip?.salesDate ?? "",
            "reviewAverage": recip?.reviewAverage ?? ""
            
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
        
        }
        
    }
        
        
    }
    
    
}
