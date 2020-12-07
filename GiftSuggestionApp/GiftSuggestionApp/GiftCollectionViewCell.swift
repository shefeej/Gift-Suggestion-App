//
//  GiftCollectionViewCell.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/7/20.
//

import UIKit
import SnapKit

class GiftCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        //imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        imageView.image = UIImage(named: "gift")
        
        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        nameLabel.text = "Gift"
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
//            make.left.equalTo(contentView.snp.left)
//            make.right.equalTo(contentView.snp.right)
            make.size.equalTo(CGSize(width: 150, height: 150))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.centerX.equalTo(imageView.snp.centerX)
            make.height.equalTo(20)
        }
    }
    
//    func configure(gift: Gift) {
//        imageView.image = UIImage(named: gift.imageName)
//        nameLabel.text = gift.name
//
//    }
    

}

