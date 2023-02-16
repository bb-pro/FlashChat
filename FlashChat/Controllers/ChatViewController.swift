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
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTF.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        navigationItem.hidesBackButton = true
        
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
    }
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error)  in
                
                self.messages = []
                
                if let e = error {
                    print(" There was an issue retrieving data from firestore \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let sender = data[K.FStore.senderField] as? String,
                               let body = data[K.FStore.bodyField] as? String {
                                self.messages.append(Message(sender: sender, body: body))
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                        self.messages.forEach { message in
                            print(message.sender, message.body)
                        }
                    }
                }
            }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTF.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    self.tableView.reloadData()
                }
            }
            
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
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        //This is a message from current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
         
        }
        
        return cell
        
    }
}
    
extension ChatViewController: UITableViewDelegate {
    
}


