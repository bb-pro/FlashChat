//
//  ProfileViewController.swift
//  FlashChat
//
//  Created by Bektemur Mamashayev on 17/02/23.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameTF: UITextField!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.delegate = self
        loginLabel.text = Auth.auth().currentUser?.email
        passwordLabel.text = Auth.auth().currentUser?.displayName
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameLabel.text = nameTF.text
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        nameTF.text = ""
    }
}
