//
//  DetailViewController.swift
//  CineSearch
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit
import Spring

class DetailViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieSynopsis: UITextView!
    @IBOutlet weak var actorOne: UILabel!
    @IBOutlet weak var actorTwo: UILabel!
    @IBOutlet weak var actorThree: UILabel!
    @IBOutlet weak var actorFour: UILabel!
    @IBOutlet weak var actorOneThumbnail: DesignableImageView!
    @IBOutlet weak var actorTwoThumbnail: DesignableImageView!
    @IBOutlet weak var actorThreeThumbnail: DesignableImageView!
    @IBOutlet weak var actorFourThumbnail: DesignableImageView!
    
    
    var movie: Movie!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetailView()
        
        movie.getMovieDetails { () -> () in
            self.updateUI()
        }
        
        movieSynopsis.delegate = self
    }
    
    func updateUI(){
        movieSynopsis.setContentOffset(CGPointZero, animated: false) //SETS TEXTVIEW TO TOP
        movieSynopsis.text = movie.overview
        
        //SETUP ACTOR NAMES
        actorOne.text = movie.actors[0]
        actorTwo.text = movie.actors[1]
        actorThree.text = movie.actors[2]
        actorFour.text = movie.actors[3]
        
        //SETUP ACTOR IMAGES
        actorOneThumbnail.kf_setImageWithURL(NSURL(string: movie.actorThumbnail[0])!)
        actorTwoThumbnail.kf_setImageWithURL(NSURL(string: movie.actorThumbnail[1])!)
        actorThreeThumbnail.kf_setImageWithURL(NSURL(string: movie.actorThumbnail[2])!)
        actorFourThumbnail.kf_setImageWithURL(NSURL(string: movie.actorThumbnail[3])!)
    }
    
    func setupDetailView(){
        let posterURL = NSURL(string:"\(TMDB_IMAGE_BASE)\(self.movie.imageURL)")
        moviePoster.kf_setImageWithURL(posterURL!)
        navBar.title = movie.title
    }
}
