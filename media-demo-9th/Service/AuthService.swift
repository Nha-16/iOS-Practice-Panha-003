//
//  AuthService.swift
//  media-demo-9th
//
//  Created by Mavin on 13/11/21.
//

import Foundation
import Alamofire
import SwiftyJSON
struct AuthService {
    static let shared = AuthService()
    
    let authURL = "http://110.74.194.124:9999/api/auth"
    
    func signIn(username: String, password: String, completion: @escaping (Result<Bool, Error>)->()){
        
        let signInUser: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        AF.request("\(authURL)/login",method: .post, parameters: signInUser, encoding: JSONEncoding.default).response { response in
        
            switch response.result {
                case .success(let data):
                    
                    let jsonData = JSON(data)
                
                let username = jsonData["payload"]["username"].stringValue
                
                let token = jsonData["payload"]["token"].stringValue
                
                UserDefaults.standard.set(username, forKey: "username")
                UserDefaults.standard.set(token, forKey: "key")
                
                completion(.success(jsonData["success"].boolValue))
  
                case .failure(let error):
                        completion(.failure(error))
                    
            }
            
        }
        
    }
    
    func signOut(completion: ()->()){
        UserDefaults.standard.set("", forKey: "username")
        UserDefaults.standard.set("", forKey: "key")
        completion()
        
    }
    
    func signUp(fullName: String, username: String, password: String, completion: @escaping(Result<Bool,Error>)->()){
        
        let signUpUser: [String:Any] = [
            "fullname": fullName,
            "username": username,
            "password": password
        ]
        
        AF.request("\(authURL)/register", method: .post ,parameters: signUpUser, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                let jsonData = JSON(data)
                
                let isSuccess = jsonData["success"].boolValue
                
                completion(.success(isSuccess))
                
                
            case .failure(let err):
                completion(.failure(err))
                print(err.localizedDescription)
            }
            
        }
    }
    
}
