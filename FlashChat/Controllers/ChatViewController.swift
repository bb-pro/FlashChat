//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Bektemur Mamashayev on 14/02/23.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTF: UITextField!
    
    var messages: [Message] = [
               Message(sender: "1@2.com", body: "Hey"),
               Message(sender: "2@3.com", body: "Hello!"),
                Message(sender: "1@2.com", body: "WhatsUpp"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTF.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        navigationItem.hidesBackButton = true
        
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if messageTF.text == "" {
            return
        } else {
            messages.append(Message(sender: "1@2.com", body: messageTF.text ?? ""))
        }
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTF.endEditing(true)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if messageTF.text == "" {
            return false
        } else {
            messages.append(Message(sender: "1@2.com", body: messageTF.text ?? ""))
            print(messages)
            return true
        }
    }
}
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        if let messageCell = cell as? MessageCell {
            messageCell.label.text = messages[indexPath.row].body
            return messageCell
        }
        return cell
    }
    
}
extension ChatViewController: UITableViewDelegate {
    
}


