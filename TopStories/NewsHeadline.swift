//
//  NewsHeadline.swift
//  TopStories
//
//  Created by Tsering Lama on 11/25/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import Foundation

// HeadlinesData.self because top level JSON is a dictionary
struct HeadlinesData: Codable {
    
    let results: [NewsHeadline]
    
}

// [NewsHeadlines].self because its an array of dictionary 
struct NewsHeadline: Codable {
    
    let title: String
    let abstract: String
    let byline: String
    
}

extension HeadlinesData {
    // parsing json into to get [NewsHeadline] objects
    static func getHeadlines() -> [NewsHeadline] {
        var headlines = [NewsHeadline]()
        // BUNDLE: allows to access in app resources and files (.json file)
        
        // get the url
        guard let fileURL = Bundle.main.url(forResource: "topStoriesTechnology", withExtension: "json") else {
            fatalError("could not located json file")
        }
        
        // get data contents from fileURL
        do {
            let data = try Data(contentsOf: fileURL)
            // Parse data to NewsHeadline.swift
            
            let headlinesData = try JSONDecoder().decode(HeadlinesData.self, from: data)
            headlines = headlinesData.results // [NewsHeadline]
            
            } catch {
            fatalError("failed to load url: \(error)")
        }
        
        return headlines
    }
}
