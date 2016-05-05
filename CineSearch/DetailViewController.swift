//
//  DetailViewController.swift
//  CineSearch
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit
import Spring
import Cosmos

class DetailViewController: UIViewController, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieSynopsis: UITextView!
    @IBOutlet weak var movieStars: CosmosView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieBudget: UILabel!
    @IBOutlet weak var movieRevenue: UILabel!
    @IBOutlet weak var movieStatus: UILabel!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    
    var movie: Movie!
    var actors = [Actor]()
    var formatter = NSNumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetailView()
        
        movie.getMovieDetails { () -> () in
            self.updateUI()
            self.actors = self.movie.actors
            self.collectionView.reloadData()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        movieSynopsis.delegate = self
    }
    
    func updateUI(){
        movieSynopsis.setContentOffset(CGPointZero, animated: false) //SETS TEXTVIEW TO TOP
        movieSynopsis.text = movie.overview
        movieStars.rating = movie.voteAverage
        movieBudget.text = formatter.stringFromNumber(movie.budget)
        movieRevenue.text = formatter.stringFromNumber(movie.revenue)
        movieStatus.text = movie.status
        movieRuntime.text = "\(movie.runtime) mins."
        movieGenres.text = movie.genres
        releaseDate.text = movie.releaseDate
    }
    
    func setupDetailView(){
        let posterURL = NSURL(string:"\(TMDB_IMAGE_BASE)\(self.movie.imageURL)")
        moviePoster.kf_setImageWithURL(posterURL!)
        navBar.title = movie.title
        // FORMAT CURRENCY
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = 0;
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(75, 120)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ActorCell", forIndexPath: indexPath) as? ActorCell {
            let actor = actors[indexPath.row]
            cell.configureCell(actor)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

}
