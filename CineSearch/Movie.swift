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
    private var _overview: String!
    private var _imageURL: String!
    private var _releaseDate: String!
    private var _tagline: String!
    private var _movieURL: String!
    private var _runtime: Int!
    private var _actors: [String]!
    private var _actorThumbnail: [String]!
    
    var title: String {
        return _title
    }
    
    var movieID: Int {
        return _movieID
    }
    
    var overview: String {
        return _overview
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
    
    var movieURL: String {
        return _movieURL
    }
    
    var actors: [String] {
        return _actors
    }
    
    var actorThumbnail: [String] {
        return _actorThumbnail
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
            var mainActors = [String]()
            var actorImages = [String]()
            if let movie = result.value as? Dictionary<String,AnyObject> {
                
                if let overview = movie["overview"] as? String {
                    self._overview = overview
                }
                
                if let credits = movie["credits"] as? Dictionary<String,AnyObject> {
                    
                    if let cast = credits["cast"] as? [Dictionary<String,AnyObject>] {
                        let actors = cast.prefix(4) // GRABBING ONLY THE MAIN CHARACTERS
                        
                        for actor in actors {
                            
                            if let name = actor["name"] as? String {
                                mainActors.append(name)
                            }
                            
                            if let profile_path = actor["profile_path"] as? String {
                                let thumbnailPath = "\(TMDB_IMAGE_BASE)\(profile_path)"
                                actorImages.append(thumbnailPath)
                            }
                        }
                        self._actors = mainActors
                        self._actorThumbnail = actorImages
                    }
                }
            }
            completed()
        }
    }
}