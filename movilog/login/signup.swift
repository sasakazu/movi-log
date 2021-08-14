//
//  signup.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/08/13.
//

import UIKit
import Firebase

class signup: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func signupBtn(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTF.text!, password: password.text!) { authResult, error in
          
            
            
        }
    }
    

}
