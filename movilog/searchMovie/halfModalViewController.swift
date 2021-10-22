//
//  halfModalViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/20.
//

import UIKit

class halfModalViewController: UIViewController {

    var halfTitle:String = ""
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        label.text = self.halfTitle
        
        print(halfTitle)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        
        
        
    }
    

}
