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
    
    func uploadImage(imageData: Data?,completion: @escaping(String?)->()){
        
        if let safeData = imageData {
            AF.upload(multipartFormData: { multiform in
                multiform.append(safeData, withName: "image", fileName: "ams", mimeType: "image/jpeg")
            }, to: "\(postURL)/image").response { response in
                
                if let error = response.error{
                    print(error.localizedDescription)
                }
                
                if let data = response.data {
                    
                    let jsonData = try! JSON(data: data)
                    
                    print(jsonData)
                    
                    let url = jsonData["url"].stringValue
                    
                    completion(url)
                    
                }
                
                
            }
        }else{
            completion(nil)
        }
        
        
    }
    
    func postPost(caption: String?, image: String?, completion: @escaping(Result<String, Error>)->()){
        
        let post: [String:Any] = [
            "caption": caption ?? "no caption",
            "image": image ?? "no image"
        ]
        
        AF.request("\(postURL)/posts/create", method: .post, parameters: post, encoding: JSONEncoding.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            }else{
                
                guard let data = response.data else {
                    return
                }
                let jsonData = try! JSON(data: data)
                print("hi",jsonData)
                completion(.success(jsonData["message"].stringValue))
            }
            
        }
        
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
