//
//  DataService.swift
//  Kyles Showcase
//
//  Created by Kyle Lee on 11/20/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import Foundation
import Firebase
let URL_BASE = "https://kyles-showcase.firebaseio.com"

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: URL_BASE)
    private var _REF_POSTS = Firebase(url: URL_BASE + "/posts")
    private var _REF_USERS = Firebase(url: URL_BASE + "/users")
    
    var REF_BASE: Firebase { return self._REF_BASE }
    var REF_POSTS: Firebase { return self._REF_POSTS }
    var REF_USERS: Firebase { return self._REF_USERS }
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>) {
        self.REF_USERS.childByAppendingPath(uid).setValue(user)
    }
}