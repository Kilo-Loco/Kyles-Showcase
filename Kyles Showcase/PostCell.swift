//
//  PostCell.swift
//  Kyles Showcase
//
//  Created by Kyle Lee on 11/22/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showcaseImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    var post: Post!
    var request: Request?
    var likeRef: Firebase!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:")
        tap.numberOfTapsRequired = 1
        self.likeImg.addGestureRecognizer(tap)
        self.likeImg.userInteractionEnabled = true
        
    }
    
    override func drawRect(rect: CGRect) {
        self.profileImg.layer.cornerRadius = self.profileImg.frame.size.width / 2
        self.profileImg.clipsToBounds = true
        
        self.showcaseImg.clipsToBounds = true
        
    }


    func configureCell(post: Post, img: UIImage?) {
        self.post = post
        self.likeRef = DataService.ds.REF_USER_CURRENT.childByAppendingPath("likes").childByAppendingPath(self.post.postKey)
        self.descriptionText.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
        if post.imageUrl != nil {
            if img != nil {
                self.showcaseImg.image = img
            } else {
                
                self.request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                    
                    if err == nil {
                        let img = UIImage(data: data!)!
                        self.showcaseImg.image = img
                        FeedVC.imageCache.setObject(img, forKey: self.post.imageUrl!)
                    } else {
                        debugPrint(err)
                    }
                    
                })
                
                
            }
        } else {
            self.showcaseImg.hidden = true
        }
    
        self.likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "heartHollow")
            } else {
                self.likeImg.image = UIImage(named: "heartFull")
            }
            
        })
        
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        
        self.likeRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let doesNotExist = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "heartFull")
                self.post.adjustLikes(true)
                self.likeRef.setValue(true)
            } else {
                self.likeImg.image = UIImage(named: "heartHollow")
                self.post.adjustLikes(false)
                self.likeRef.removeValue()
            }
            
        })
        
    }

}
