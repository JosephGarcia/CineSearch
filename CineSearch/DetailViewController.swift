//
//  DetailViewController.swift
//  CineSearch
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var moviePoster: UIImageView!
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        let posterURL = NSURL(string:"\(TMDB_MOVIE_POSTER_BASE)\(self.movie.imageURL)")
        moviePoster.kf_setImageWithURL(posterURL!)
        navBar.title = movie.title
    }
}
