//
//  resultDetail.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/01.
//

import UIKit

class resultDetail: UIViewController {

    var detailTitle:String = ""
    var artistName:String = ""
    var salesDate:String = ""
    var average:String = ""
    var imageUrl:String = ""
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var directedLabel: UILabel!
    @IBOutlet weak var saleDateLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTitle.text = detailTitle
        directedLabel.text = artistName
        saleDateLabel.text = salesDate
        averageLabel.text =  average
        
//        画像表示
        let url = URL(string: imageUrl)
        do {
            let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            movieImage.image = image
            
        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
    
    }
    




}
    


