//
//  comment.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/30.
//

import UIKit
import Firebase

class comment: UIViewController, UITextViewDelegate {

    
    var documentID:String = ""
    var comment:String = ""
    
    @IBOutlet weak var commentTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        commentTV.becomeFirstResponder()
        commentTV.delegate = self
        
        commentTV.layer.cornerRadius = 5.0
        commentTV.layer.masksToBounds = true
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        let docRef = db.collection("users").document(user!.uid).collection("post").document(documentID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                
                self.comment = document.data()?["comment"] as? String ?? ""

                self.commentTV.text = self.comment
                
                print(self.comment)
//                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
        
        print(documentID)
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveBtn(_ sender: Any) {

        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        
        let Ref = db.collection("users").document(user!.uid).collection("post").document(documentID)

        let allRef = db.collection("allPosts").document(documentID)
        
        Ref.updateData([
            "comment": commentTV.text
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    
        allRef.updateData([
            "comment": commentTV.text
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        
        
        self.navigationController?.popViewController(animated: true)


    }
    
}
