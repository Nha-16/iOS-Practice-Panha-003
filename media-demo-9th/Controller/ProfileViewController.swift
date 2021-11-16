//
//  ProfileViewController.swift
//  media-demo-9th
//
//  Created by Mavin on 13/11/21.
//

import UIKit

class ProfileViewController: UIViewController {

    let screenManager = (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        print("work")
        
        let SignInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC")
        
        AuthService.shared.signOut {
            
            print("signout")

            screenManager.changeRootView(SignInVC)
        }
        
    }


}
