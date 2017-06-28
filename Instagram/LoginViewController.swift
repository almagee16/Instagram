//
//  LoginViewController.swift
//  Instagram
//
//  Created by Alvin Magee on 6/26/17.
//  Copyright © 2017 Alvin Magee. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    let alertController = UIAlertController(title: "Empty inputs", message: "Please provide both a username and a password", preferredStyle: .alert)
    
    let invalidUserName = UIAlertController(title: "Invalid Username", message: "This username already exists. Please choose another username", preferredStyle: .alert)
    
    let invalidLoginCredentials = UIAlertController(title: "Invalid Login Credentials", message: "Please ensure that you are using the correct username and password and try again", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        alertController.addAction(OKAction)
        invalidUserName.addAction(OKAction)
        invalidLoginCredentials.addAction(OKAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        if username.isEmpty || password.isEmpty {
            present(self.alertController, animated: true) {
                
            }
        } else {
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: { (user: PFUser?, error: Error?) in
                if let error = error {
                    let errorInfo = error._userInfo as! [String: Any]
                    let code = errorInfo["code"] as! Int
                    if code == 101 {
                        self.present(self.invalidLoginCredentials, animated: true) {
                        }
                    }
                    
                } else {
                    print("User logged in successfully")
                    // display view controller that needs to shown after successful login
                    print ("about to perform segue")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            })
        }

    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        let username = usernameField.text as! String
        let password = passwordField.text as! String
        
        if username.isEmpty || password.isEmpty
        {
            present(self.alertController, animated: true) {
                
            }
        } else {
            newUser.username = usernameField.text
            newUser.password = passwordField.text
        
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    let errorInfo = error._userInfo as! [String: Any]
                    let code = errorInfo["code"] as! Int
                    if code == 202 {
                        self.present(self.invalidUserName, animated: true) {
                            
                        }
                    }
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }

            }
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
