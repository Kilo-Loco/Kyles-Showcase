//
//  DataService.swift
//  Kyles Showcase
//
//  Created by Kyle Lee on 11/20/15.
//  Copyright © 2015 Kyle Lee. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "https://kyles-showcase.firebaseio.com")
    
    var REF_BASE: Firebase { return self._REF_BASE }
    
}