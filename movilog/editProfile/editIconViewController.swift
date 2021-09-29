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

    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Auth.auth().currentUser {
//        ユーザーアイコンの取得
            let storageref = Storage.storage().reference(forURL: "gs://movi-log.appspot.com/").child("images").child(user.uid).child("\(user.uid).jpg")

        iconImageView.sd_setImage(with:storageref)
        
//        print("my icon is url\(storageref)")
        
        
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
