//
//  tLMovieDetailViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/10/07.
//

import UIKit
import Firebase

class tLMovieDetailViewController: UIViewController {

    
//    var movieID:String = ""
    
    var moviehoge:String = ""
    var Imagehoge:String = ""
    var artisthoge:String = ""
    var saleDatehoge:String = ""
    var reviewhoge:String = ""
    
    @IBOutlet weak var movieIcon: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var salesLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTitle.text = moviehoge
        artistLabel.text = artisthoge
        salesLabel.text = "発売日：\(saleDatehoge)"
        averageLabel.text = "平均評価：\(reviewhoge)"
        
        let url = URL(string: Imagehoge)
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            movieIcon.image = image
            
        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func goToSiteBtn(_ sender: Any) {
        
        
    }
    

}
