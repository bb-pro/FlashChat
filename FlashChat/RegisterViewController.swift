//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Bektemur on 11/02/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class RegisterViewController: UIViewController {
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }


    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTF.text, let password = passwordTF.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    //Navigate to the ChatViewController
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
            }
        }
    }
    
}
