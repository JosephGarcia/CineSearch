//
//  DetailViewController.swift
//  CineSearch
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieSynopsis: UITextView!
    
    
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        movieSynopsis.delegate = self
        setupDetailView()
        movie.getMovieDetails { () -> () in
            self.updateUI()
        }
    }
    
    func updateUI(){
        movieSynopsis.setContentOffset(CGPointZero, animated: false) //SETS TEXTVIEW TO TOP
        movieSynopsis.text = movie.overview
    }
    
    func setupDetailView(){
        let posterURL = NSURL(string:"\(TMDB_MOVIE_POSTER_BASE)\(self.movie.imageURL)")
        moviePoster.kf_setImageWithURL(posterURL!)
        navBar.title = movie.title
    }
}
