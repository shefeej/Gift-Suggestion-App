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
        
        imageView.image = UIImage(named: gift.imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        nameLabel.text = gift.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
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
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
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
