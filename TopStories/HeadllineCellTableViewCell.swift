//
//  HeadllineCellTableViewCell.swift
//  TopStories
//
//  Created by Tsering Lama on 11/25/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

class HeadllineCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var headlineImgaeView: UIImageView!
    @IBOutlet weak var headlineTitle: UILabel!
    @IBOutlet weak var byLine: UILabel!
    
    // add corner radius
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headlineImgaeView.layer.cornerRadius = 4 // CGFloat 
    }
    
    func configureCell(headline: NewsHeadline) {
        headlineTitle.text = headline.title
        byLine.text = headline.byline
    }
    
}
