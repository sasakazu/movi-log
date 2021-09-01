//
//  resultTableViewCell.swift
//  
//
//  Created by 笹倉一也 on 2021/09/01.
//

import UIKit

class resultTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    let bodyTextLabel: UILabel = {
          let label = UILabel()
          label.text = "something in here"
          label.font = .systemFont(ofSize: 15)
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    let userImageView: UIImageView = {
          let iv = UIImageView()
           iv.contentMode = .scaleAspectFill
           iv.translatesAutoresizingMaskIntoConstraints = false
           iv.clipsToBounds = true
           return iv
       }()
    
    var books: SerchBookKList.ItemDic.ItemInfo? {
            didSet {
                bodyTextLabel.text = books?.title
                let url = URL(string: books?.smallImageUrl ?? "")
                do {
                    let data = try Data(contentsOf: url!)
                    let image = UIImage(data: data)
                    userImageView.image = image
                }catch let err {
                    print("Error : \(err.localizedDescription)")
                }
            }
        }
    
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)

           addSubview(userImageView)
           addSubview(bodyTextLabel)
           [
               userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
               userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
               userImageView.widthAnchor.constraint(equalToConstant: 50),
               userImageView.heightAnchor.constraint(equalToConstant: 50),

               bodyTextLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 20),
               bodyTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

               ].forEach{ $0.isActive = true }

           userImageView.layer.cornerRadius = 50 / 2
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
   }
    
    
    

