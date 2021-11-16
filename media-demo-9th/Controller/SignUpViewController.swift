//
//  SignUpViewController.swift
//  media-demo-9th
//
//  Created by Mavin on 13/11/21.
//

import UIKit
import ProgressHUD

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullnameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        guard let fullName = fullnameTextField.text,
              let username = usernameTextField.text,
              let password = passwordTextField.text else {
                  return
              }
        if fullName == "" || username == "" || password == ""{
            ProgressHUD.showError("All Field are required")
        }else{
            
            ProgressHUD.show()
            
            AuthService.shared.signUp(fullName: fullName, username: username, password: password, completion: { result in
                
                switch result {
                case .success(let isSuccess):
                    if isSuccess {
                        ProgressHUD.showSucceed("Register Successfully")
                    }else{
                        ProgressHUD.showError("Register Fail")
                    }
                case .failure(let error):
                    ProgressHUD.showError(error.localizedDescription)
                }
                 
            })
        }
        
        
        
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }


}
