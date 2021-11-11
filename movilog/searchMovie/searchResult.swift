//
//  searchResult.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/01.
//

import UIKit
import Firebase
import SwiftUI

class searchResult: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    var booklists = [SerchBookKList]()
    var inputKeyword:String = ""
    var words:String = ""
    var titlewords:String = ""
    
    var test:String = ""
    
//    監督名
    var inputDirect:String = ""
    
    private let cellId = "cellId"
    
////    user情報
//    var userName = ""
//    var userIcon = ""
    
    @IBOutlet weak var tableviewTest: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("dddddkkkkkkkkkkkk\(inputDirect)")
        print("dddddkkkkkkkkkkkk\(inputKeyword)")
        
        tableviewTest.delegate = self
        tableviewTest.dataSource = self
        searchTF.delegate = self
        
        tableviewTest.register(UINib(nibName: "resultCell", bundle: nil), forCellReuseIdentifier: cellId)
        
  
        searchTF.text = inputKeyword
        searchTF.text = inputDirect
        
//        utf8に変換
        let item = self.inputKeyword
        let directitem = self.inputDirect
        
        self.words = item.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        
        self.titlewords = directitem.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        
        getRApi()
        getDApi()
    
        

    }

//    タイトルで検索api
    private func getRApi(){
           guard let url = URL(string: "https://app.rakuten.co.jp/services/api/BooksDVD/Search/20170404?format=json&title=\(words)&booksGenreId=003&affiliateId=1828b17e.d3807f48.1828b17f.30ede62b&applicationId=1024730205059605378") else {return}
        
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
   
    //    監督名で検索api
        private func getDApi(){
               guard let url = URL(string: "https://app.rakuten.co.jp/services/api/BooksDVD/Search/20170404?format=json&artistName=\(titlewords)&booksGenreId=003&affiliateId=1828b17e.d3807f48.1828b17f.30ede62b&applicationId=1024730205059605378") else {return}
            
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
       
   
//    セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
       }
    
//  セルの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (booklists.count == 0) {
                          return booklists.count
                      } else {
                        return booklists[0].Items?.count ?? 0
            }
    }
    


//セルに表示させる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! resultCell
        
        cell.button.setTitle("登録する", for: .normal)
        
        cell.button.addTarget(self, action: #selector(tappedOnXibCellButton), for: .touchUpInside)
      
        cell.button.tag = indexPath.row
        
        cell.recip = booklists[0].Items?[indexPath.row].Item

        return cell

    }
    
//    ハーフモーダルへ
    @objc func tappedOnXibCellButton(sender: UIButton) {

        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "halfModalView") as! halfModalViewController
     
//        print(button.tag)

        let row = sender.tag
              
//          print(row)
          
//          test = booklists[0].Items?[row].Item?.title ?? "kk"
          
//        ここでデータを送る
        secondViewController.halfTitle = booklists[0].Items?[row].Item?.title ?? "no data"
        
        secondViewController.artist = booklists[0].Items?[row].Item?.artistName ?? "no data"
        secondViewController.imageUrl = booklists[0].Items?[row].Item?.largeImageUrl ?? "no data"
        secondViewController.sales = booklists[0].Items?[row].Item?.salesDate ?? "no data"
        secondViewController.review = booklists[0].Items?[row].Item?.reviewAverage ?? "no data"
        secondViewController.affiliUrl = booklists[0].Items?[row].Item?.affiliateUrl ?? "no data"
        secondViewController.jancode = booklists[0].Items?[row].Item?.jan ?? "no data"
        self.present(secondViewController, animated: true, completion:nil)
        
        if #available(iOS 15.0, *) {
            if let sheet = secondViewController.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24.0
                
                
            }
        } else {
            // Fallback on earlier versions
        }

//        secondViewController.halfTitle = test
        
    }
        
    
//    セルを選択した時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print("\(indexPath.row)番目の行が選択されました。")
        
//        tableView.deselectRow(at: indexPath, animated: true)
        
//        print(test)
//        print(booklists[0].Items?[indexPath.row].Item?.title)
//            performSegue(withIdentifier: "goModal", sender: indexPath.row)
//        print(indexPath.row)
        
        performSegue(withIdentifier: "goDetail", sender: indexPath.row)
    }
    
//    詳細画面にデータを送る
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goDetail" {
            if let nextVC = segue.destination as? resultDetail,

                let index = sender as? Int {

                nextVC.detailTitle = self.booklists[0].Items?[index].Item?.title ?? ""
                    nextVC.artistName = booklists[0].Items?[index].Item?.artistName ?? ""
                    nextVC.salesDate = booklists[0].Items?[index].Item?.salesDate ?? ""
                    nextVC.average = booklists[0].Items?[index].Item?.reviewAverage ?? ""
                    nextVC.imageUrl = booklists[0].Items?[index].Item?.largeImageUrl ?? ""
                    nextVC.affiliUrl = booklists[0].Items?[index].Item?.affiliateUrl ?? ""
                 

            }
        }
}

//    キーボードを閉じたら検索開始
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            // キーボードを隠す
            textField.resignFirstResponder()
            
            let itemString = textField.text
            let String = textField.text
            
            self.words = itemString?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""

            self.titlewords = String?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
 

            getRApi()
            getDApi()
            
            return true
        
    }
    
    
    
    
}
