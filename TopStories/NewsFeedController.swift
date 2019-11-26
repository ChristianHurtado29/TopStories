//
//  ViewController.swift
//  TopStories
//
//  Created by Tsering Lama on 11/25/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

enum SearchScope {
    case title
    case abstract
}

class NewsFeedController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var headlines = [NewsHeadline]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var currentScope = SearchScope.title // default value is 0 "title" scope
    
    // TODO: create a variable called searchQuery that calls filter method
    var searchQuery = ""{
        didSet{
            switch currentScope {
            case .title:
                headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchQuery.lowercased() )}
            case .abstract:
                headlines = HeadlinesData.getHeadlines().filter { $0.abstract.lowercased().contains(searchQuery.lowercased() )}
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        headlines = HeadlinesData.getHeadlines()
    }
    
    
    func filterHeadlines(for searchText: String) {
        guard !searchText.isEmpty else{ return }
        headlines = HeadlinesData.getHeadlines().filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. get destination view controller
        // 2. we need the indexPath the user selected from the table view
        guard let newsDetailController = segue.destination as? NewsDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("verify class name in the \"identity inspactor\"")
        }
        
        // 3. get the selected headline
        let headline = headlines[indexPath.row]
        
        // 4. set the newsDetailController
        newsDetailController.newsHeadline = headline
        
        
    }
    
    
}
extension NewsFeedController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "headLineCell", for: indexPath) as? HeadllineCellTableViewCell else {
            fatalError()
        }
        let news = headlines[indexPath.row]
        cell.configureCell(headline: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

}

extension NewsFeedController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // dismiss the keyboard
        searchBar.resignFirstResponder()

    }
    
    // TODO: real time searching as the user types
    // TODO: what happens when the search bar is empty
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            // searchText is empty here so we get back all the de original headlines by using our loadData() heper function
            loadData()
            return
        }
        searchQuery = searchText
//        filterHeadlines(for: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            currentScope = .title
        case 1:
            currentScope = .abstract
        default:
            print("Not a valid search scope")
        }
    }
    
    
}
