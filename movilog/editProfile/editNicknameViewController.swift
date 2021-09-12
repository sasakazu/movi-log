//
//  editNicknameViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/12.
//

import UIKit
import Firebase

class editNicknameViewController: UIViewController {

    
    @IBOutlet weak var nicknameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
        // Do any additional setup after loading the view.
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
        
    
    }
    

}
