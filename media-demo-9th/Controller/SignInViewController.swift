//
//  SignInViewController.swift
//  media-demo-9th
//
//  Created by Mavin on 13/11/21.
//

import UIKit
import ProgressHUD
class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    let screenManager = (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let token = UserDefaults.standard.string(forKey: "key") {
            
            if token != "" {
                let MainTab = self.storyboard?.instantiateViewController(withIdentifier: "MainTab")
                    
                self.screenManager.changeRootView(MainTab)

                }
           
            }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else {
                  return
              }
        if username == "" || password == ""{
            ProgressHUD.showError("All Field are required")
        }else{
            ProgressHUD.show()
            AuthService.shared.signIn(username: username, password: password) { result in
                switch result {
                    
                case .success(let isSuccess):
                
                    if !isSuccess {
                        ProgressHUD.showError("Login Fail")
                    }else{
                        
                    ProgressHUD.dismiss()
                        
                    let MainTab = self.storyboard?.instantiateViewController(withIdentifier: "MainTab")
                        
                    self.screenManager.changeRootView(MainTab)
                        
                        print("login Success")
                    }
                    
                case .failure(let error):
                    ProgressHUD.showError(error.localizedDescription)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
