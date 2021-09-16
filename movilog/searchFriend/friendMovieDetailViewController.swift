//
//  friendMovieDetailViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/16.
//

import UIKit
import Firebase

class friendMovieDetailViewController: UIViewController {

//    映画情報変数
    var movieHako:String = ""
    var ImageHako:String = ""
    var movieArtist:String = ""
    var movieSaleDate:String = ""
    var movieReview:String = ""
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var artistTitle: UILabel!
    @IBOutlet weak var saleDateLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTitle.text = movieHako
        artistTitle.text = movieArtist
        saleDateLabel.text = movieSaleDate
        reviewLabel.text = movieReview
        
//        映画イメージ
        let url = URL(string: ImageHako)
            do {
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                movieImage.image = image
                    
                }catch let err {
                    print("Error : \(err.localizedDescription)")
            }
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func gotoRakuten(_ sender: Any) {
    }
    

}
