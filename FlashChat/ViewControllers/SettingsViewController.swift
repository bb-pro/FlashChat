//
//  SettingsViewController.swift
//  FlashChat
//
//  Created by Bektemur Mamashayev on 19/02/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var themeSwithc: UISwitch!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func themeSwticherPressed(_ sender: UISwitch) {
        if sender.isOn {
            let app = UIApplication.shared
            app.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else if !sender.isOn {
            let app = UIApplication.shared
            app.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }

    }
    
    @IBAction override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        dismiss(animated: true)
    }
}
