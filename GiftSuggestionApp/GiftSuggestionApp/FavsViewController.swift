//
//  FavsViewController.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/7/20.
//

import UIKit

class FavsViewController: UIViewController {

    var tableView: UITableView!
    let reuseIdentifier = "favCellReuse"

    private var favGifts: [Gift] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //testlist = [test,test,test,test,test,test,test,test,test,test]

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)

        getFavGifts()
        setupConstraints()

    }

    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

    }
    
    private func getFavGifts() {
        NetworkManager.getFavGifts(userId: 1) { (gifts) in
            self.favGifts = gifts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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

extension FavsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favGifts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FavsTableViewCell
        cell.configure(gift: favGifts[indexPath.row])
        return cell
    }
}

extension FavsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gift = favGifts[indexPath.row]
        let detailViewController = DetailViewController(gift: gift)
        navigationController?.pushViewController(detailViewController, animated: true)

    }
}
