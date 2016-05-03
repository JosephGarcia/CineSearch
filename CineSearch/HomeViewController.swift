//
//  ViewController.swift
//  CineSearch
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var popularMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        displayMovies()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == HOME_TO_DETAIL {
            if let detailVC = segue.destinationViewController as? DetailViewController {
                if let movie = sender as? Movie {
                    detailVC.movie = movie
                }
            }
        }
    }
    
    // VC FUNCTIONS
    func displayMovies() {
        let helper = APIHelper()
        
        helper.showPopularMovies { (movies) -> Void in
            self.popularMovies = movies
            self.collectionView.reloadData()
        }
    }
    
    // COLLECTION VIEW CONTROLS
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let currentCell = collectionView.cellForItemAtIndexPath(indexPath) as! MovieCell
        currentCell.cellAnimate()
        let movie: Movie
        movie = popularMovies[indexPath.row]
        performSegueWithIdentifier(HOME_TO_DETAIL, sender: movie)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(150, 260)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCell {
            
            let movie: Movie
            movie = popularMovies[indexPath.row]
            cell.configureCell(movie)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
}

