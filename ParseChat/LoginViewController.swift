//
//  LoginViewController.swift
//  ParseChat
//
//  Created by TiAuna Dodd on 2/26/18.
//  Copyright © 2018 TiAuna Dodd. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    let alertController = UIAlertController(title: "Invalid", message: "Enter Username and Password", preferredStyle: .alert)
    
    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LoginButton(_ sender: Any) {

        if UsernameTextField.text == "" && PasswordTextField.text == ""{
            // create a cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true)
            
        }else{
                loginUser()
        }
    }
    
    @IBAction func SignupButton(_ sender: Any) {
        
        if UsernameTextField.text == "" && PasswordTextField.text == ""{
            // create a cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true)
            
        }else{
            registerUser()
        }
    
    }

    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = UsernameTextField.text
        newUser.password = PasswordTextField.text
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func loginUser() {
        
        let username = UsernameTextField.text ?? ""
        let password = PasswordTextField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
               self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }


}
