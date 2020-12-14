//
//  BottomViewController.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/7/20.
//

import UIKit

class BottomViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        title = "Gift Suggestion"
        //        self.navigationController!.navigationBar.barStyle = .default
        //        self.navigationController!.navigationBar.isTranslucent = true
        //        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        //        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        //        navigationItem.prompt = NSLocalizedString("Navigation prompts appear at the top.", comment: "jkhgjfu")

        //        navigationController?.navigationBar.barTintColor = UIColor(red:1, green:0.45, blue:0.42, alpha:1.0)
        //        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "AvenirNext-DemiBold", size: 23)!]
        //        navigationController?.navigationBar.isTranslucent = false
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //        navigationController?.navigationBar.shadowImage = UIImage()
        //        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            // Create Tab one
            let tabOne = ViewController()
            let tabOneBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

            tabOne.tabBarItem = tabOneBarItem


            // Create Tab two
            let tabTwo = FavsViewController()
        let tabTwoBarItem2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

            tabTwo.tabBarItem = tabTwoBarItem2


            self.viewControllers = [tabOne, tabTwo]
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

extension BottomViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            print("Selected \(viewController)")
        }
}
