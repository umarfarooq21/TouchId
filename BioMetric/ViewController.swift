//
//  ViewController.swift
//  BioMetric
//
//  Created by Muhammad Umar Farooq on 3/1/19.
//  Copyright © 2019 Umar Farooq. All rights reserved.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {
    
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var imgBio: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    
    
    let keychain = Keychain(service: "com.BioMetric")

    @IBAction func storeTapped(_ sender: Any) {
        DispatchQueue.global().async {
            do {
                
                try self.keychain
                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                    .set(self.tfUsername.text!, key: "secretUsername")
                
                try self.keychain
                        .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .userPresence)
                        .set(self.tfPassword.text!, key: "seceretPassword")
                
            }catch let error {
                print(error)
            }
        }
        
        tfUsername.resignFirstResponder()
        tfPassword.resignFirstResponder()
    }
    
    @IBAction func getInfoTapped(_ sender: Any) {
        
        DispatchQueue.global().async {
            do {
                let username = try self.keychain
                    .authenticationPrompt("Authe prompt for username")
                    .get("secretUsername")
                
                DispatchQueue.main.async {
                    // Update UI
                    self.lblUsername.text = "Username is \(String(describing: username!))"
                }
                
                let passowrd = try self.keychain
                    .authenticationPrompt("Auth prompt for password")
                    .get("seceretPassword")
                
                DispatchQueue.main.async {
                    // Update UI
                    self.lblPassword.text = "Passowrd is \(String(describing: passowrd!))"
                }
                
            }catch let error {
                print(error)
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(biometricType == .touchID) {
            imgBio.image = UIImage(named: "TouchID")
        } else if(biometricType == .faceID) {
            imgBio.image = UIImage(named: "FaceID")
        } else if(biometricType == .none) {
            print("This device has no touch id sensor.")
        }
    }
    
}

