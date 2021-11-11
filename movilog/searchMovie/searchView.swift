//
//  searchView.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/08/13.
//

import UIKit

class searchView: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var directedTF: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchTF.delegate = self
        directedTF.delegate = self
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            // キーボードを隠す
        textField.resignFirstResponder()
            
        
        performSegue(withIdentifier: "sendKeyword", sender: nil)
        
            return true
        }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "sendKeyword" {
            if let nextVC = segue.destination as? searchResult {
           
                nextVC.inputKeyword = searchTF.text ?? ""
                nextVC.inputDirect = directedTF.text ?? ""
            
                
            
        }
    }
}
    

}
