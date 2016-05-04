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
    private var _actors: [Actor]!
    private var _releaseDate: String!
    private var _movieURL: String!
    private var _runtime: Int!
    private var _voteAverage: Double!
    private var _budget: Int!
    private var _revenue: Int!
    private var _status: String!
    
    var title: String {
        return _title
    }
    
    var movieID: Int {
        return _movieID
    }
    
    var imageURL: String {
        return _imageURL
    }
    
    var overview: String {
        if _overview == nil {
            _overview = "N/A"
        }
        return _overview
    }
    
    var releaseDate: String {
        if _releaseDate == nil {
            _releaseDate = "N/A"
        }
        return _releaseDate
    }
    
    var runtime: Int {
        if _runtime == nil {
            _runtime = 0
        }
        return _runtime
    }
    
    var movieURL: String {
        return _movieURL
    }
    
    var voteAverage: Double {
        return _voteAverage
    }
    
    var actors: [Actor] {
        return _actors
    }
    
    var budget: Int {
        return _budget
    }
    
    var revenue: Int {
        return _revenue
    }
    
    var status: String {
        return _status
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
            var actorName = String()
            var actorThumbnail = String()
            var actorsInMovie = [Actor]()
            if let movie = result.value as? Dictionary<String,AnyObject> {
                
                if let overview = movie["overview"] as? String {
                    self._overview = overview
                }
                
                if let vote_average = movie["vote_average"] as?  Double {
                    // DIVING BY 2 SINCE API HAS 10 STAR SYSTEM. APP ONLY HAS 5 STAR.
                    self._voteAverage = vote_average / 2
                }
                
                if let status = movie["status"] as? String {
                    self._status = status
                }
                
                if let revenue = movie["revenue"] as? Int {
                    self._revenue = revenue
                }
                
                if let budget = movie["budget"] as? Int {
                    self._budget = budget
                }
                
                if let runtime = movie["runtime"] as? Int {
                    self._runtime = runtime
                }
                
                if let releaseDate = movie["release_date"] as? String {
                    self._releaseDate = releaseDate
                }
                
                if let credits = movie["credits"] as? Dictionary<String,AnyObject> {
                    
                    if let actors = credits["cast"] as? [Dictionary<String,AnyObject>] {
                        
                        for actor in actors {
                            
                            if let name = actor["name"] as? String {
                                actorName = name
                            }
                            
                            if let profile_path = actor["profile_path"] as? String {
                                let thumbnailPath = "\(TMDB_IMAGE_BASE)\(profile_path)"
                                actorThumbnail = thumbnailPath
                            } else {
                                actorThumbnail = ""
                            }
                            
                            let actorData = Actor(name: actorName, thumbnail: actorThumbnail)
                            actorsInMovie.append(actorData)
                        }
                        self._actors = actorsInMovie
                    }
                }
            }
            completed()
        }
    }
}