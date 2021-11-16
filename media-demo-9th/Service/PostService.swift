//
//  PostService.swift
//  media-demo-9th
//
//  Created by Mavin on 13/11/21.
//

import Foundation
import Alamofire
import SwiftyJSON

struct PostService {
    static let shared = PostService()
    let postURL = "http://110.74.194.124:9999/api"
    
    let headers: HTTPHeaders = [
        "Content-Type": "Application/Json",
        "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "key") ?? "")"
    ]
    
    func uploadImage(){
        
    }
    
    func postPost(){
        
    }
    
    func fetchPost(completion: @escaping (Result<[Post],Error>)->()){
        AF.request("\(postURL)/posts", headers: headers).response { response in
            
            switch response.result {
            case .success(let data):
                
                let jsonData = JSON(data)
                let payload = jsonData["payload"].arrayValue
                
                var posts: [Post] = []
                for postJSON in payload {
                    let post = Post(json: postJSON)
                    posts.append(post)
                }
                completion(.success(posts))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
