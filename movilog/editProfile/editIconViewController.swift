//
//  editIconViewController.swift
//  movilog
//
//  Created by 笹倉一也 on 2021/09/26.
//

import UIKit
import Firebase
import SDWebImage

class editIconViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    var userIconsave:String = ""
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Auth.auth().currentUser {
//        ユーザーアイコンの取得
            let storageref = Storage.storage().reference(forURL: "gs://movi-log.appspot.com/").child("images").child(user.uid).child("\(user.uid).jpg")

            
//            iconImageView.sd_setImage(with:storageref))?.resized(size: CGSize(width: 100, height: 100))
            
        iconImageView.sd_setImage(with:storageref)
        
//            iconImageView.image = sd_setImage(with: storageref)
            
//        print("my icon is url\(storageref)")
        
//            imageseihoukei.image = UIImage(named: "im")?.resized(size: CGSize(width: 100, height: 100))
            
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveBtn(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        

        
        let image:UIImage! = iconImageView.image
        
        
        let date = NSDate()
              let currentTimeStampInSecond = UInt64(floor(date.timeIntervalSince1970 * 1000))
        let storageRef = Storage.storage().reference().child("images").child(user!.uid).child("\(user!.uid).jpg")

        
              let metaData = StorageMetadata()
              metaData.contentType = "image/jpg"
              if let uploadData = self.iconImageView.image?.jpegData(compressionQuality: 0.9) {
                  storageRef.putData(uploadData, metadata: metaData) { (metadata , error) in
                      if error != nil {
                          print("error: \(error?.localizedDescription)")
                      }
                      storageRef.downloadURL(completion: { (url, error) in
                          if error != nil {
                              print("error: \(error?.localizedDescription)")
                          }
                          print("url: \(url?.absoluteString)")
                          
                          self.userIconsave = url?.absoluteString ?? "no url"
                          
//                          print(self.userIconsave)
                          //        userに登録
//                                     
//                                     userIconsave = storageRef
                                     
                                     let db = Firestore.firestore()
                                     
                                     db.collection("users").document(user!.uid).updateData([
                                        "userIcon": self.userIconsave
                                     ]) { err in
                                         if let err = err {
                                             print("Error writing document: \(err)")
                                         } else {
                                             print("Document successfully written!")
                                         }
                                     }
                             
                      })
                  }
              }
        
   
    }
    
    // 書き込み完了結果の受け取り
     @objc func image(_ image: UIImage,
                      didFinishSavingWithError error: NSError!,
                      contextInfo: UnsafeMutableRawPointer) {
         
         if error != nil {
             print(error.code)
//             label.text = "Save Failed !"
         }
         else{
             
//             let resizedImage = selectedImg.convert(toSize:CGSize(width:100.0, height:100.0), scale: UIScreen.main.scale)
//
//               // TODO: whatever you want to do with your resized image
//               employeePhoto.image = resizedImage
//
             
             
             
//             label.text = "Save Succeeded"
         }
     }
    

    
    @IBAction func cameraBtn(_ sender: Any) {
    
//        let sourceType:UIImagePickerController.SourceType =
//                  UIImagePickerController.SourceType.camera
//              // カメラが利用可能かチェック
//              if UIImagePickerController.isSourceTypeAvailable(
//                  UIImagePickerController.SourceType.camera){
//                  // インスタンスの作成
//                  let cameraPicker = UIImagePickerController()
//                  cameraPicker.sourceType = sourceType
//                  cameraPicker.delegate = self
//                  self.present(cameraPicker, animated: true, completion: nil)
//
//              }
//
//              else{
//                  print("error")
//
//        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        if let pickedImage = info[.originalImage]
            as? UIImage {
            
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.image = pickedImage
            
            
            let resizedImage = pickedImage.resized(size: CGSize(width: 100, height: 100))

              // TODO: whatever you want to do with your resized image
              iconImageView.image = resizedImage
            
            
        }
 
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    // 撮影がキャンセルされた時に呼ばれる
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           picker.dismiss(animated: true, completion: nil)
          
       }
    
    @IBAction func albumBtn(_ sender: Any) {
    
        let sourceType:UIImagePickerController.SourceType =
               UIImagePickerController.SourceType.photoLibrary
           
           if UIImagePickerController.isSourceTypeAvailable(
               UIImagePickerController.SourceType.photoLibrary){
               // インスタンスの作成
               let cameraPicker = UIImagePickerController()
               cameraPicker.allowsEditing = true
               cameraPicker.sourceType = sourceType
               cameraPicker.delegate = self
               self.present(cameraPicker, animated: true, completion: nil)
               
           }
           else{
                print("eroor")
           }
           
        
    }
    
}


extension UIImage {
    func resized(size: CGSize) -> UIImage {
        // リサイズ後のサイズを指定して`UIGraphicsImageRenderer`を作成する
        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { (context) in
            // 描画を行う
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

