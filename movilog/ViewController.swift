//
//  ViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/08/05.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let user = Auth.auth().currentUser
            if let user = user {
        
            let uid = user.uid
            let email = user.email
              
            print(uid)
            print(email!)
            
        }
    }


    
    
    
    
}

