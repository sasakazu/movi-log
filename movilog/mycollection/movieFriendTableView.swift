//
//  movieFriendTableView.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/30.
//

import UIKit
import Firebase

class movieFriendTableView: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    private let cellId = "cellId"

    @IBOutlet weak var movieFTableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieFTableview.register(UINib(nibName: "movieFTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        movieFTableview.delegate = self
        movieFTableview.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! movieFTableViewCell
        
//        cell.recip = booklists[0].Items?[indexPath.row].Item

        return cell
        
    }

}
