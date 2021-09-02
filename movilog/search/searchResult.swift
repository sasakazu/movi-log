//
//  searchResult.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/01.
//

import UIKit

class searchResult: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var booklists = [SerchBookKList]()
    
    
    private let cellId = "cellId"
    
    
    @IBOutlet weak var tableviewTest: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableviewTest.delegate = self
        tableviewTest.dataSource = self
        
        tableviewTest.register(UINib(nibName: "resultCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        getRApi()

    }

    private func getRApi(){
           guard let url = URL(string: "https://app.rakuten.co.jp/services/api/BooksDVD/Search/20170404?format=json&artistName=%E3%82%AF%E3%83%AA%E3%82%B9%E3%83%88%E3%83%95%E3%82%A1%E3%83%BC%E3%83%8E%E3%83%BC%E3%83%A9%E3%83%B3&booksGenreId=003&applicationId=1024730205059605378") else {return}

           let task = URLSession.shared.dataTask(with: url) { (data, response, err)in
               if let err = err {
                   print("情報の取得に失敗しました。:", err)
                   return
               }
               if let data = data{
                   do{
                       let resultList = try JSONDecoder().decode(SerchBookKList.self, from: data)
                       self.booklists = [resultList]
                    
                       DispatchQueue.main.async {
                                              self.tableviewTest.reloadData()
                                          }
                    print("json: ", resultList)
                    
                   }catch(let err){
                        print("情報の取得に失敗しました。:", err)

                   }
               }
           }
           task.resume()
       }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
       }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (booklists.count == 0) {
                          return booklists.count
                      } else {
                        return booklists[0].Items?.count ?? 0
            }
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! resultCell
        
        cell.recip = booklists[0].Items?[indexPath.row].Item

        return cell

    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//            print("\(indexPath.row)番目の行が選択されました。")
        
            tableView.deselectRow(at: indexPath, animated: true)
        
            performSegue(withIdentifier: "toNextViewController", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toNextViewController" {
            if let nextVC = segue.destination as? resultDetail,
               
               let index = sender as? Int {
           
                nextVC.detailTitle = booklists[0].Items?[index].Item?.title ?? ""
                nextVC.artistName = booklists[0].Items?[index].Item?.artistName ?? ""
                nextVC.salesDate = booklists[0].Items?[index].Item?.salesDate ?? ""
                nextVC.average = booklists[0].Items?[index].Item?.reviewAverage ?? ""
                nextVC.imageUrl = booklists[0].Items?[index].Item?.largeImageUrl ?? ""
                
            
        }
    }
}

    
    
    
}
