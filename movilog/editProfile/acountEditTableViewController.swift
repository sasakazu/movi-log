//
//  acountEditTableViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/12.
//

import UIKit
import Firebase

class acountEditTableViewController: UITableViewController {

    var nickname:String = ""
    var email:String = ""
    
    @IBOutlet weak var movilogIDLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        
        let user = Auth.auth().currentUser
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(user!.uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {

                self.nickname = document["nickname"] as? String ?? "no nickname"
                self.email = document["email"] as! String
                
                
                //labelにニックネームを表示
                self.movilogIDLabel.text = "\(self.nickname) > "
//                メールアドレスを表示
                self.emailLabel.text = self.email
                
            } else {
                print("Document does not exist")
            }
        }
        
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if indexPath.row == 1 {
            let myWebView = self.storyboard!.instantiateViewController(withIdentifier: "editIcon") as! editIconViewController
            self.show(myWebView, sender: nil)
            
            }
       
        if indexPath.row == 2 {
            let myWebView = self.storyboard!.instantiateViewController(withIdentifier: "nickname") as! editNicknameViewController
            self.show(myWebView, sender: nil)
            
            }
       
        if indexPath.row == 3 {
            let myWebView = self.storyboard!.instantiateViewController(withIdentifier: "editEmail") as! editEmailViewController
            self.show(myWebView, sender: nil)
        
            }
        

        
    }
    

    @IBAction func logoutBtn(_ sender: Any) {
        
        
        let refreshAlert = UIAlertController(title: "ログアウト", message: "ログアウトしてもよろしいですか？", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
            
            let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
            
                    let storyboard: UIStoryboard = self.storyboard!
            
                    let nextView = storyboard.instantiateViewController(withIdentifier: "signup") as! signup
            
                    self.present(nextView, animated: true, completion: nil)
            
                    print("logout!")
            
                    } catch let signOutError as NSError {
                        print("Error signing out: %@", signOutError)
                    }
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
        
        

        
       
    }
    

    
    //    詳細画面にデータを送る
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//            if segue.identifier == "gotoNickname" {
//                if let nextVC = segue.destination as? editNicknameViewController,
//
//                   let index = sender as? Int {
//
//                    nextVC.nicknamePF = self.nickname ?? ""
//
//            }
//        }
//
//            else if segue.identifier == "goEditEmail" {
//                if let nextVC = segue.destination as? editEmailViewController,
//
//                   let index = sender as? Int {
//
//                    nextVC.emailPF = self.email ?? ""
//
//            }
//        }
//    }

}
