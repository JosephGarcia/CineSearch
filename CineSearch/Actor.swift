//
//  Actor.swift
//  CineSearch
//
//  Created by Joseph Garcia on 5/3/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import Foundation


class Actor {
    private var _name: String!
    private var _thumbnail: String
    
    var name: String {
        return _name
    }
    
    var thumbnail: String {
        return _thumbnail
    }
    
    init(name: String! , thumbnail: String){
        self._name = name
        self._thumbnail = thumbnail
    }
}
