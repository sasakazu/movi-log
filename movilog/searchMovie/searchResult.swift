//
//  searchResult.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/01.
//

import UIKit
import Firebase

class searchResult: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    
    var booklists = [SerchBookKList]()
    var inputKeyword:String = ""
    var words:String = ""
    
    private let cellId = "cellId"
    
////    user情報
//    var userName = ""
//    var userIcon = ""
    
    @IBOutlet weak var tableviewTest: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableviewTest.delegate = self
        tableviewTest.dataSource = self
        searchTF.delegate = self
        
        tableviewTest.register(UINib(nibName: "resultCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        searchTF.text = inputKeyword
        
//        utf8に変換
        let item = self.inputKeyword
        self.words = item.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        
        getRApi()
    
        

    }

//    rakuten api 叩く
    private func getRApi(){
           guard let url = URL(string: "https://app.rakuten.co.jp/services/api/BooksDVD/Search/20170404?format=json&artistName=\(words)&booksGenreId=003&applicationId=1024730205059605378") else {return}

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


//    let items = UIMenu(options: .displayInline, children: [
//        UIAction(title: "メニュー3", image: UIImage(systemName: "pencil"), handler: { _ in
//            print("メニュー3が押されました")
//        }),
//        UIAction(title: "メニュー2", image: UIImage(systemName: "envelope"), handler: { _ in
//            print("メニュー2が押されました")
//
////            self.test = "menu2"
////            print(self.test)
//        }),
//        UIAction(title: "メニュー1", image: UIImage(systemName: "network.badge.shield.half.filled"), handler: { _ in
//            print("メニュー1が押されました")
//        }),
//    ])

//        let destruct = UIAction(title: "削除する", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in }

//    button.menu = UIMenu(title: "", children: [items])
//    button.showsMenuAsPrimaryAction = true
    
//セルに表示させる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! resultCell
        
        cell.recip = booklists[0].Items?[indexPath.row].Item

//        cell.button.menu = UIMenu(title: "", children: [items])
//        cell.button.showsMenuAsPrimaryAction = true

        
        return cell

    }

    
//    セルを選択した時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//            print("\(indexPath.row)番目の行が選択されました。")
        
            tableView.deselectRow(at: indexPath, animated: true)
        
            performSegue(withIdentifier: "toNextViewController", sender: indexPath.row)
        
    }
    
//    詳細画面にデータを送る
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

//    キーボードを閉じたら検索開始
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            // キーボードを隠す
            textField.resignFirstResponder()
            
            let itemString = textField.text
            
            self.words = itemString?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""

            getRApi()
            
            return true
        }
    
    
    
    
}
