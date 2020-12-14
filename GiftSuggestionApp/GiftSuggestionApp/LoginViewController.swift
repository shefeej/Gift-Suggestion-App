//
//  LoginViewController.swift
//  GiftSuggestionApp
//
//  Created by Tiantian Li on 12/15/20.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    var nameLabel: UILabel!
//    var passwordLabel: UILabel!
    var nameTextField: UITextField!
    var username = ""
    var loginButton: UIButton!
    var signupButton: UIButton!
//    var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.text = "Username:"
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameTextField = UITextField()
        nameTextField.placeholder = "Enter Username"
        nameTextField.text = username
        nameTextField.font = UIFont.systemFont(ofSize: 20)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.blue, for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        signupButton = UIButton()
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
//        passwordLabel = UILabel()
//        passwordLabel.textColor = .black
//        passwordLabel.text = "Password"
//        passwordLabel.font = UIFont.systemFont(ofSize: 20)
//        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(passwordLabel)
//
//        passwordTextField = UITextField()
//        passwordTextField.placeholder = "Enter Username"
//        passwordTextField.text = password
//        passwordLabel.font = UIFont.systemFont(ofSize: 20)
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(passwordTextField)
        
        setUpConstriants()
    }
    
    func setUpConstriants() {
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(80)
            make.centerY.equalTo(view).offset(-50)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.left.equalTo(nameLabel.snp.right).offset(30)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.left.equalTo(nameLabel.snp.left).offset(50)
            make.size.equalTo(CGSize(width: 80, height: 50))
        }
        
        signupButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.top)
            make.left.equalTo(loginButton.snp.right).offset(20)
            make.size.equalTo(CGSize(width: 80, height: 50))
        }
        
    }
    
    @objc func login() {
        loginButton.setTitleColor(.darkGray, for: .normal)
        let vc = BottomViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func signup() {
        signupButton.setTitleColor(.darkGray, for: .normal)
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
