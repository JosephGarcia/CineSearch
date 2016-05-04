//
//  constants.swift
//  CineSearch
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import Foundation
import UIKit

// EXAMPLE API CALL
// https://api.themoviedb.org/3/movie/550?api_key=34a46b49db5c44899a8ffe4bf365854b
// API KEY
// ?api_key=34a46b49db5c44899a8ffe4bf365854b


//URLS
let TMDB_API_KEY = "?api_key=34a46b49db5c44899a8ffe4bf365854b"
let TMDB_BASE_URL = "https://api.themoviedb.org/3/movie"
let TMDB_APPEND_RESPONSE = "&append_to_response=credits"
let TMDB_POPULAR_MOVIES_URL = "https://api.themoviedb.org/3/movie/popular?api_key=34a46b49db5c44899a8ffe4bf365854b"
let TMDB_SEARCH_MOVIES_URL = "https://api.themoviedb.org/3/search/movie?api_key=34a46b49db5c44899a8ffe4bf365854b&query="
let TMDB_IMAGE_BASE = "http://image.tmdb.org/t/p/w500"


//SEGUES
let HOME_TO_DETAIL = "homeToDetail"
let SEARCH_TO_DETAIL = "searchToDetail"

// COLORS
let SHADOW_COLOR: CGFloat = 157.0 / 255.0

//CLOSURES
typealias DownloadComplete = () -> ()