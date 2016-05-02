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
    private var _movieURL: String!
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
    
    var movieURL: String{
        return _movieURL
    }
        
    init(title: String!, id: Int!, imageURL: String!){
        self._title = title
        self._movieID = id
        self._imageURL = imageURL
        
        _movieURL = "\(TMDB_BASE_URL)/\(self.movieID)\(TMDB_API_KEY)\(TMDB_APPEND_RESPONSE)" // GRABS MOVIE WITH ID TOGETHER WITH CREDITS AND IMAGES
    }
    
    func getMovieDetails(completed: DownloadComplete){
        let url = NSURL(string: _movieURL)!
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            let result = response.result
            
        }
    }
}