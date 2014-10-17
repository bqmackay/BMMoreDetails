//
//  FancyTableViewController.swift
//  BMMoreDetails
//
//  Created by Byron Mackay on 10/16/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import UIKit

class FancyTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var detailsShowing = false
    let gridSize = 9
    var gameboardHeight = CGFloat(321)
    var gameboard:GameboardCell?

    let SPONSOR_HEADER_HEIGHT = CGFloat(30.0)
    let BANNER_HEADER_HEIGHT = CGFloat(321)
    let DETAILS_HEADER_HEIGHT = CGFloat(63.5)
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = 5
        if detailsShowing {
            cellCount++
        }
        return cellCount
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return SPONSOR_HEADER_HEIGHT
        case 1:
            return BANNER_HEADER_HEIGHT
        case 2:
            return DETAILS_HEADER_HEIGHT
        case 3:
            if detailsShowing {
                return 300
            } else {
                return gameboardHeight
            }
        case 4:
            if detailsShowing {
                return gameboardHeight
            } else {
                return 45
            }
        default :
            return 45
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            tableView.registerNib(UINib(nibName: "SponsorHeaderView", bundle: nil)!, forCellReuseIdentifier: "SponsorHeader")
            return tableView.dequeueReusableCellWithIdentifier("SponsorHeader") as UITableViewCell
        } else if indexPath.row == 1 {
            tableView.registerNib(UINib(nibName: "BannerHeaderView", bundle: nil)!, forCellReuseIdentifier: "BannerHeader")
            return tableView.dequeueReusableCellWithIdentifier("BannerHeader") as UITableViewCell
        } else if indexPath.row == 2 {
            return tableView.dequeueReusableCellWithIdentifier("cell1") as UITableViewCell
        } else if indexPath.row == 3 && detailsShowing {
            return tableView.dequeueReusableCellWithIdentifier("cell3") as UITableViewCell
        } else if (indexPath.row == 3 && !detailsShowing) || (indexPath.row == 4 && detailsShowing) {
            if let cell = gameboard {
                println("Using existing cell")
                gameboard?.layoutIfNeeded()
                return cell
            }
            gameboard = GameboardCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell", itemCount: gridSize)!
            return gameboard!
        } else {
            return tableView.dequeueReusableCellWithIdentifier("SponsorHeader") as UITableViewCell
        }
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell is GameboardCell {
            let gameboardCell = cell as GameboardCell
            gameboardCell.setCollectionViewDataSourceDelegate((self, self), index: indexPath.row)
        }
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    @IBAction func expandDetails(sender: AnyObject) {
        detailsShowing = !detailsShowing
        let newIndexPath = NSIndexPath(forRow: 3, inSection: 0)
        
        tableView.beginUpdates()
        if detailsShowing {
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        } else {
            tableView.deleteRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Middle)
        }
        tableView.endUpdates()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridSize
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.grayColor()
        return cell
    }
    
}
