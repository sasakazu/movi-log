//
//  editNicknameViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/12.
//

import UIKit
import Firebase

class editNicknameViewController: UIViewController {

    var nicknamePF:String = ""
    
    @IBOutlet weak var nicknameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let user = Auth.auth().currentUser
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(user!.uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                self.nicknamePF = document["nickname"] as? String ?? "no nickname"
                
                self.nicknameTF.text = self.nicknamePF
                
            } else {
                print("Document does not exist")
            }
        }

    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
    
        let user = Auth.auth().currentUser
        
        let db = Firestore.firestore()
        
        db.collection("users").document(user!.uid).updateData([
            "nickname": nicknameTF.text ?? "no nickname"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        self.navigationController?.popViewController(animated: true)

        
    }
    

}
