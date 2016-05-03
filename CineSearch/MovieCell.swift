//
//  MovieCell.swift
//  CineSearch
//
//  Created by Joseph Garcia on 5/1/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit
import Spring
import Kingfisher

class MovieCell: UICollectionViewCell{
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var movie: Movie!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 3.0
        layer.masksToBounds = false;
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 6.0
        layer.shadowOffset = CGSizeMake(0.0, 3.0)
    }
    
    func configureCell(movie: Movie){
        self.movie = movie
        let placeholder = UIImage(named: "moviePlaceholder")
        let imageURL = NSURL(string:"\(TMDB_IMAGE_BASE)\(self.movie.imageURL)")
        moviePoster.kf_setImageWithURL(imageURL!, placeholderImage: placeholder)
        movieTitle.text = self.movie.title
    }

}
