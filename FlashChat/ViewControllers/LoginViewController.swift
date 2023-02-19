//
//  LoginViewController.swift
//  FlashChat
//
//  Created by Bektemur on 11/02/23.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {

    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTF.text, let password = passwordTF.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
            
        }
    }
}
