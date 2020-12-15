//
//  FavsTableViewCell.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/7/20.
//

import UIKit
import Kingfisher

class FavsTableViewCell: UITableViewCell {
    
    var favImageView: UIImageView!
    var nameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        favImageView = UIImageView()
        favImageView.contentMode = .scaleAspectFit
        favImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(favImageView)
        
        nameLabel = UILabel()
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        favImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.left.equalTo(contentView.snp.left)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(favImageView.snp.top)
            make.left.equalTo(favImageView.snp.right).offset(30)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(gift: Gift) {
        let photoURL = URL(string: gift.imageUrl)
        favImageView.kf.setImage(with: photoURL)
        nameLabel.text = gift.name
    }

}
