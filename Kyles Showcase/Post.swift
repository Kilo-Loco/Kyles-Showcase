//
//  Post.swift
//  Kyles Showcase
//
//  Created by Kyle Lee on 11/23/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _postDescription: String!
    private var _imageUrl: String?
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    private var _postRef: Firebase!
    
    var postDescription: String { return self._postDescription }
    var imageUrl: String? { return self._imageUrl }
    var likes: Int { return self._likes }
    var username: String { return self._username }
    var postKey: String { return self._postKey }
    
    
    init(description: String, imageUrl: String?, username: String) {
        self._postDescription =  description
        self._imageUrl = imageUrl
        self._username = username
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
        }
        
        if let imgUrl = dictionary["imageUrl"] as? String {
            self._imageUrl = imgUrl
        }
        
        if let desc = dictionary["description"] as? String {
            self._postDescription = desc
        }
        
        self._postRef = DataService.ds.REF_POSTS.childByAppendingPath(self._postKey)
    }
    
    func adjustLikes(addLike: Bool) {
        
        if addLike {
            self._likes = self._likes + 1
        } else {
            self._likes = self._likes - 1
        }
        
        self._postRef.childByAppendingPath("likes").setValue(_likes)
        
    }
    
}