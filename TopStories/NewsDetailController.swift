//
//  NewsDetailControllerCollectionViewController.swift
//  TopStories
//
//  Created by Christian Hurtado on 11/26/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewsDetailController: UIViewController {

    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headlineAbstractTextView: UITextView!
    @IBOutlet weak var bylineLabel: UILabel!
    
    var newsHeadline: NewsHeadline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        guard let headline = newsHeadline else {
            fatalError("fucked shit up bruh = check ya segue hoe")
        }
        // TODO: set up image processing using URLSession() and DispatchQueuelmain.async{...}
        navigationItem.title = headline.title
        headlineAbstractTextView.text = headline.abstract
        bylineLabel.text = headline.byline
    }
    
}
