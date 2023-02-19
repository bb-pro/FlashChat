//
//  ProfileViewController.swift
//  FlashChat
//
//  Created by Bektemur Mamashayev on 17/02/23.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var setPhotoButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPhotoButton.setTitle("Установить фото профиля", for: .normal)
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // or .camera
        
        loginLabel.text = Auth.auth().currentUser?.email
        
    }
    @IBAction func setPhotoPressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
        setPhotoButton.setTitle("Изменить фото", for: .normal)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
        }
        else {
            dismiss(animated: true)
        }
    }
    
}
