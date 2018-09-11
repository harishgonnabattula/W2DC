//
//  ViewController.swift
//  W2DC
//
//  Created by Ninja on 8/25/18.
//  Copyright © 2018 Ninja. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    @IBOutlet weak var videoTableView: UITableView!

    private var dataSource = DataFromJSON.shared.videos
    private var placeHolderDataSource = [VideoViewModel]()
    private var expandCellAtIndex = [Bool]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearchController()
        videoTableView.estimatedRowHeight = 250
        videoTableView.tableFooterView = UIView()
        expandCellAtIndex = (0...dataSource.count).map({ (val) -> Bool in
            false
        })
        placeHolderDataSource = dataSource
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
        searchController.searchBar.placeholder = "Ex: Core Data"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "video", for: indexPath) as! VideoTableViewCell
        if(expandCellAtIndex[indexPath.row]) {
            cell.summaryLabel.numberOfLines = 0
            cell.summaryLabel.lineBreakMode = .byWordWrapping
        }
        else{
            cell.summaryLabel.numberOfLines = 2
            cell.summaryLabel.lineBreakMode = .byTruncatingTail
        }
        cell.configureCell(withURL: dataSource[indexPath.row].url, thumbnail: dataSource[indexPath.row].videoThumbnail, description: dataSource[indexPath.row].summary)
        cell.contentView.setCardView(view: cell.thumbnailImage)
        
        cell.fullScreenDelegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! VideoTableViewCell).removePlayerFromView()
    }
}


//TODO:- Not working now
extension ViewController: FullScreenVideoDelegate {
    func presentVideoInFullScreen(player: AVPlayer) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let avController = appDelegate.avPlayerController
        avController.player = player
        avController.showsPlaybackControls = true
        self.present(avController, animated: true) {
            player.play()
        }
    }
    func reloadCell(cell: VideoTableViewCell) {
        let index = videoTableView.indexPath(for: cell)!
        expandCellAtIndex[index.row] = true
        UIView.setAnimationsEnabled(false)
        videoTableView.beginUpdates()
        videoTableView.reloadRows(at: [index], with: .automatic)
        videoTableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if(searchController.searchBar.text == ""){
            dataSource = placeHolderDataSource
        }
        else{
            dataSource = placeHolderDataSource.filter { (vm) -> Bool in
                vm.title.contains(searchController.searchBar.text!)
            }
        }
        videoTableView.reloadData()
    }
}
