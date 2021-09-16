//
//  editEmailViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/14.
//

import UIKit
import Firebase

class editEmailViewController: UIViewController {

    var emailPF:String = ""
    
    @IBOutlet weak var emailTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(user!.uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                self.emailPF = document["email"] as! String
                
                self.emailTF.text = self.emailPF
                
            } else {
                print("Document does not exist")
            }
        }

    }
    


}
