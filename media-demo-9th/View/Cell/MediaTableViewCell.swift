//
//  MediaTableViewCell.swift
//  media-demo-9th
//
//  Created by Mavin on 13/11/21.
//

import UIKit
import Kingfisher

class MediaTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonComment: UIButton!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(post: Post){
        
        self.profileImage.kf.setImage(with: URL(string:  "https://ui-avatars.com/api/?name=\(post.username)"), options: [.transition(.fade(0.5))])
        
        self.usernameLabel.text = post.username
        self.captionLabel.text = post.caption
        self.buttonLike.setTitle("\(post.numberOfLikes) Likes", for: .normal)
        self.postImage.kf.setImage(with: URL(string:"\(post.image)"), placeholder: UIImage(systemName: "camera.fill"), options: [.transition(.fade(0.5))])
        
    }
    
    
   
    
}
