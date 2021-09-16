//
//  movieCollectionDetail.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/08.
//

import UIKit

class movieCollectionDetail: UIViewController {

    
    var selectedTitle:String = ""
    var selectedImage:String = ""
    var selectedArtist:String = ""
    var selectedSaleDate:String = ""
    var selectedReviewAverage:String = ""
    

    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var companyLabe: UILabel!
    
    @IBOutlet weak var saleDate: UILabel!
    
    @IBOutlet weak var averageLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTitle.text = selectedTitle
        artist.text = selectedArtist
        saleDate.text = selectedSaleDate
        averageLabel.setTitle(selectedReviewAverage, for: .normal)
        
        //        画像表示
        let url = URL(string: selectedImage)
            do {
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                selectedImageView.image = image
                    
                }catch let err {
                    print("Error : \(err.localizedDescription)")
            }
        
        // Do any additional setup after loading the view.
    }
    

}
