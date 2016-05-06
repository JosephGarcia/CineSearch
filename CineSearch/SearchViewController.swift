//
//  SearchViewController.swift
//  CineSearch
//
//  Created by Joseph Garcia on 4/30/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsText: UILabel!
    
    let helper = APIHelper()
    var searchResults = [Movie]()
    var searchingForMovies = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        self.collectionView.emptyDataSetDelegate = self
        self.collectionView.emptyDataSetSource = self
        
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        searchBar.resignFirstResponder()
    }
    
    //VC FUNCTIONS
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchingForMovies = true
        let query = searchBar.text!
        resultsText.hidden = false
        resultsText.text = "Results for '\(query)'"
        
        helper.searchForMovies(query) { (results) -> Void in
            self.searchResults = results
            self.collectionView.reloadData()
        }
        
        searchBar.resignFirstResponder()
        collectionView.setContentOffset(CGPoint(x: 0, y: 2), animated: true)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        collectionView.addGestureRecognizer(tap)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        collectionView.gestureRecognizers?.removeLast()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    // COLLECTION VIEW CONTROLS
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = collectionView.cellForItemAtIndexPath(indexPath) as! MovieCell
        currentCell.cellAnimate()
        
        searchBar.resignFirstResponder()
        
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
    // EMPTY DATA SET 
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let stringColor = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        var emptyDesc = NSAttributedString(string: "Search your favorite movies!", attributes: stringColor )
        
        if searchingForMovies && searchResults.count == 0 {
            emptyDesc = NSAttributedString(string: "Sorry, we couldn't find any movies relating to \"\(searchBar.text!)\"", attributes: stringColor )
        }
        
        return emptyDesc
    }

    
}
