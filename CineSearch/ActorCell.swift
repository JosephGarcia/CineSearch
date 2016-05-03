//
//  ActorCell.swift
//  CineSearch
//
//  Created by Joseph Garcia on 5/3/16.
//  Copyright © 2016 joebeard. All rights reserved.
//

import UIKit
import Spring

class ActorCell: UICollectionViewCell {


    @IBOutlet weak var actorThumbnail: DesignableImageView!
    @IBOutlet weak var actorName: UILabel!
    var actor: Actor!
    
    
    func configureCell(actor: Actor){
        self.actor = actor
        let placeholder = UIImage(named: "placeholder")
        actorThumbnail.kf_setImageWithURL(NSURL(string: actor.thumbnail)!, placeholderImage: placeholder)
        actorName.text = actor.name
    }
}
