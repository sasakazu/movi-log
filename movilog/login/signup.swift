//
//  signup.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/08/13.
//

import UIKit
import Firebase
import FirebaseFirestore

class signup: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func signupBtn(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTF.text!, password: password.text!) { authResult, error in
          
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            
            let uid = user?.uid
            
            db.collection("users").document(uid!).setData([
                
                "username": self.emailTF.text!
            
            
            ], merge: true)
            
//                    db.collection("user").document().setData([
//                        "id" : self.emailTF!
                    
                
        }
    }


    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
            
                print("Error signing out: %@", signOutError)
    
            }
      
    }
    
    
    
}
