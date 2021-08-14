//
//  movilog.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/08/13.
//

import UIKit
import Firebase

class movilog: UIViewController {

    
    @IBOutlet weak var username: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        if let user = user {
    
            let email = user.email! as String

            //ボタンにユーザーネームの表示
            username.setTitle("\(email) >", for: UIControl.State.normal)
            
        }
    }
    

    
    
    


}
