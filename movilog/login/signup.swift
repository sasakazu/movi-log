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
    @IBOutlet weak var nickNameTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let user = Auth.auth().currentUser?.uid
        print("now user\(String(describing: user))")
    
    }
    

    @IBAction func signupBtn(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTF.text!, password: password.text!) { authResult, error in
          
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser

            let uid = user?.uid

            db.collection("users").document(uid!).setData([

                "email": self.emailTF.text!,
                "userID": uid ?? "",
                "nickname": self.nickNameTF.text!
            
            ], merge: true)
                    
                
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
