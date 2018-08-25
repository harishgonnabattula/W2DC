//
//  ViewController.swift
//  W2DC
//
//  Created by Ninja on 8/25/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let dataSource = [VideoViewModel]()//DataFromJSON.shared.videos
    
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearchController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initializeSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter the Video Name"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "video", for: indexPath)
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("")
    }
}

extension ViewController:UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

    
}

