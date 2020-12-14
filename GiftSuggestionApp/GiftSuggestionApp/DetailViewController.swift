//
//  DetailViewController.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/7/20.
//

import UIKit

//TODO: add star button

class DetailViewController: UIViewController {
    
    private var gift: Gift!
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let favButton = UIButton()
    
    init(gift: Gift) {
        super.init(nibName: nil, bundle: nil)
        self.gift = gift
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Details"
        
        imageView.image = UIImage(named: "gift")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        nameLabel.text = gift.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        priceLabel.text = String(gift.price)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        favButton.setTitle("Add to Favorites", for: .normal)
        favButton.setTitleColor(.black, for: .normal)
        //favButton.backgroundColor = .lightGray
        favButton.layer.borderWidth = 3
        //favButton.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favButton)
        favButton.addTarget(self, action: #selector(addToFavs), for: .touchUpInside)
        
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    
    private func setupConstraints() {
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.equalTo(view.snp.left).offset(80)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.centerY)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.left.equalTo(imageView.snp.left)
            make.size.equalTo(CGSize(width: 150, height: 50))
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.top)
            make.left.equalTo(nameLabel.snp.right).offset(10)
            make.height.equalTo(50)
        }
        
        favButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.centerY).offset(100)
            make.size.equalTo(CGSize(width: 200, height: 70))
        }
    }
    
    @objc func addToFavs() {
        favButton.setTitle("Added", for: .normal)
        favButton.setTitleColor(.red, for: .normal)
        favButton.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        NetworkManager.addToFav(userId: 1, giftId: gift.id) { (user) in
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
