//
//  ViewController.swift
//  media-demo-9th
//
//  Created by Mavin on 13/11/21.
//

import UIKit
import ProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        self.tableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        
        fetch()
        
    }
    
    func fetch(){
        PostService.shared.fetchPost { result in
            switch result {
                case .success(let allPosts):
                self.posts = allPosts
                self.tableView.reloadData()
                case .failure(let error):
                    ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! MediaTableViewCell
        cell.selectionStyle = .none
        cell.config(post: posts[indexPath.row])
        
        return cell
    }
    
    
}

