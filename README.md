# W2DC
Collection of WWDC videos

A video player app which plays all the WWDC videos from 2015-2018.
The videos have been crawled using a python scraper.
A preview video player in tableview cells and can be expanded to fit a Fullscreen AVPlayer.
Doesnt make the tableview scrolling lag.
Made the player initialization lazy and hence the performance is good.
Added a search bar to search the videos and play. Linked the Tableview with NSFetchedResultsController for easy fetching of the data from CoreData.
Added OperationQueue for downloading the videos. The Operations execute serially.
