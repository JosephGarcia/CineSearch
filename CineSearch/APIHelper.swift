//
//  APIHelper.swift
//  CineSearch
//
//  Created by Joseph Garcia on 5/1/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import Foundation
import Alamofire


class APIHelper {
    func showPopularMovies(passMovies:(movies:[Movie]) -> Void){
        var popularMovies = [Movie]()
        var title = String()
        var id = Int()
        var imageURL = String()
        Alamofire.request(.GET, TMDB_POPULAR_MOVIES_URL).responseJSON { (response) -> Void in
            let result = response.result
            if let database = result.value as? Dictionary<String,AnyObject> {
                
                if let movies = database["results"] as? [Dictionary<String, AnyObject>] {
                    for movie in movies {
                        // CREATE MOVIE 
                        if let movieTitle = movie["title"] as? String {
                            title = movieTitle
                        }
                        
                        if let posterURL = movie["poster_path"] as? String {
                            imageURL = posterURL
                        }
                        
                        if let movieID = movie["id"] as? Int {
                            id = movieID
                        }
                        
                        let movie = Movie(title: title, id: id, imageURL: imageURL)
                        popularMovies.append(movie)
                    }
                    passMovies(movies: popularMovies)
                }
            }
        }
    }
    
    func searchForMovies(query: String, searchComplete:(results:[Movie]) -> Void){
        var searchResults = [Movie]()
        var title = String()
        var id = Int()
        var imageURL = String()
        let encodedQuery = query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let searchURL = "\(TMDB_SEARCH_MOVIES_URL)\(encodedQuery)"
        print(encodedQuery)
        
        Alamofire.request(.GET, searchURL).responseJSON { (response) -> Void in
            let result = response.result
            if let database = result.value as? Dictionary<String,AnyObject> {
                
                if let movies = database["results"] as? [Dictionary<String, AnyObject>] {
                    
                    for movie in movies {
                        // CREATE MOVIE
                        if let movieTitle = movie["title"] as? String {
                            title = movieTitle
                        }
                        
                        if let posterURL = movie["poster_path"] as? String {
                            imageURL = posterURL
                        } else {
                            imageURL = ""
                        }
                        
                        if let movieID = movie["id"] as? Int {
                            id = movieID
                        }
                        
                        let movie = Movie(title: title, id: id, imageURL: imageURL)
                        searchResults.append(movie)
                    }
                    searchComplete(results: searchResults)
                }
            }
        }
    }
}