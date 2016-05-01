//
//  Movie.swift
//  CineSearch
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import Foundation
import Alamofire


class Movie {
    private var _title: String!
    private var _movieID: Int!
    private var _description: String!
    private var _imageURL: String!
    private var _releaseDate: String!
    private var _tagline: String!
    private var _runtime: Int!
    
    var title: String {
        return _title
    }
    
    var movieID: Int {
        return _movieID
    }
    
    var description: String {
        return _description
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var releaseDate: String {
        return _releaseDate
    }
    
    var tagline: String {
        return _tagline
    }
    
    var runtime: Int {
        return _runtime
    }
        
    init(title: String!, id: Int!, imageURL: String!){
        self._title = title
        self._movieID = id
        self._imageURL = imageURL
    }
}