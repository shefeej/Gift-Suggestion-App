//
//  ViewController.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/6/20.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    var filterLabel: UILabel!
    var moneyLabel: UILabel!
    var dashLabel: UILabel!
    var moneyPickerView: UIPickerView!
    var ageLabel: UILabel!
    var agePickerView: UIPickerView!
    var occasionLabel: UILabel!
    var occasionPickerView: UIPickerView!
    var giftCollectionView: UICollectionView!
    let giftCellReuseIdentifier = "giftCellReuseIdentifier"
    
    let test = Gift(imageName: "gift", name: "Gift")
    var testlist: [Gift]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testlist = [test,test,test,test,test,test,test,test]

        view.backgroundColor = .white
        
        
        //searchBar.delegate = self
        searchBar.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Enter gift"
        searchBar.searchTextField.backgroundColor = .lightGray
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.font = .systemFont(ofSize: 14)
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.layer.cornerRadius = 15
        searchBar.layer.masksToBounds = true
        view.addSubview(searchBar)
        
        filterLabel = UILabel()
        filterLabel.textColor = .black
        filterLabel.text = "Filters"
        filterLabel.font = UIFont.systemFont(ofSize: 20)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterLabel)
        
        moneyLabel = UILabel()
        moneyLabel.textColor = .black
        moneyLabel.text = "$"
        moneyLabel.font = UIFont.systemFont(ofSize: 20)
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moneyLabel)

        dashLabel = UILabel()
        dashLabel.text = "———"
        dashLabel.textColor = .black
        dashLabel.font = UIFont.systemFont(ofSize: 20)
        dashLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dashLabel)
        
        moneyPickerView = UIPickerView()
        moneyPickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(moneyPickerView)
        moneyPickerView.dataSource = self
        //agePickerView.delegate = self
        
        ageLabel = UILabel()
        ageLabel.text = "age"
        ageLabel.textColor = .black
        ageLabel.font = UIFont.systemFont(ofSize: 20)
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ageLabel)
        
        agePickerView = UIPickerView()
        agePickerView.translatesAutoresizingMaskIntoConstraints = false
        agePickerView.dataSource = self
        view.addSubview(agePickerView)
        
        occasionLabel = UILabel()
        occasionLabel.text = "occasion"
        occasionLabel.textColor = .black
        occasionLabel.font = UIFont.systemFont(ofSize: 20)
        occasionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(occasionLabel)
        
        occasionPickerView = UIPickerView()
        occasionPickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(occasionPickerView)
        occasionPickerView.dataSource = self
        
        let giftLayout = UICollectionViewFlowLayout()
        giftLayout.scrollDirection = .vertical
        
        giftCollectionView = UICollectionView(frame: .zero, collectionViewLayout: giftLayout)
        giftCollectionView.register(GiftCollectionViewCell.self, forCellWithReuseIdentifier: giftCellReuseIdentifier)
        giftCollectionView.delegate = self
        giftCollectionView.dataSource = self
        giftCollectionView.backgroundColor = .white
        giftCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(giftCollectionView)

        setUpConstraints()
    }
    
    func setUpConstraints() {
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 350, height: 40))
        }
        
        filterLabel.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.size.equalTo(CGSize(width: 70, height: 40))
        }
        
        moneyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(filterLabel.snp.bottom).offset(10)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(70)
        }
        
        dashLabel.snp.makeConstraints { (make) in
            make.top.equalTo(filterLabel.snp.bottom).offset(8)
            make.left.equalTo(moneyLabel.snp.right).offset(170)
        }
        
        moneyPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(filterLabel.snp.bottom)
            make.size.equalTo(CGSize(width: 200, height: 40))
            make.left.equalTo(moneyLabel.snp.right).offset(90)
        }
        
        ageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(moneyLabel.snp.bottom).offset(20)
            make.left.equalTo(moneyLabel.snp.left)
        }
        
        agePickerView.snp.makeConstraints { (make) in
            make.top.equalTo(ageLabel.snp.top).offset(-5)
            make.left.equalTo(moneyPickerView.snp.left)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        occasionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ageLabel.snp.bottom).offset(20)
            make.left.equalTo(moneyLabel.snp.left)
        }
        
        occasionPickerView.snp.makeConstraints { (make) in
            make.top.equalTo(occasionLabel.snp.top).offset(-5)
            make.left.equalTo(moneyPickerView.snp.left)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        giftCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-400)
            make.left.equalTo(view.snp.left).offset(40)
            make.right.equalTo(view.snp.right).offset(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

    }
    
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == moneyPickerView {
            return 2
        }
        else {
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 10
        } else {
            return 100
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "First \(row)"
        } else {
            return "Second \(row)"
        }
    }
    
}

//extension ViewController: UIPickerViewDelegate {
//
//}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = giftCollectionView.dequeueReusableCell(withReuseIdentifier: giftCellReuseIdentifier, for: indexPath) as! GiftCollectionViewCell
//        cell.configure(gift: testlist[indexPath.item])
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let gift = testlist[indexPath.item]
        let detailViewController = DetailViewController(gift: test)
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let size = collectionView.frame.width - 2 * padding / 2.0
        return CGSize(width: 170, height: 170)
    }
}

