//
//  SearchViewController.swift
//  CineSearch
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsText: UILabel!
    
    let helper = APIHelper()
    var searchResults = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEARCH_TO_DETAIL {
            if let detailVC = segue.destinationViewController as? DetailViewController {
                if let movie = sender as? Movie {
                    detailVC.movie = movie
                }
            }
        }
    }
    
    //VC FUNCTIONS
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let query = searchBar.text!
        resultsText.hidden = false
        resultsText.text = "Results for '\(query)'"
        
        helper.searchForMovies(query) { (results) -> Void in
            self.searchResults = results
            self.collectionView.reloadData()
        }
        
        searchBar.resignFirstResponder()
    }
    
    // COLLECTION VIEW CONTROLS
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let movie: Movie
        movie = searchResults[indexPath.row]
        performSegueWithIdentifier(SEARCH_TO_DETAIL, sender: movie)
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
            movie = searchResults[indexPath.row]
            cell.configureCell(movie)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }

    
}
