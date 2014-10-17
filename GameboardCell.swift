//
//  GameboardCell.swift
//  BMMoreDetails
//
//  Created by Byron Mackay on 10/17/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import UIKit

class GameboardCell: UITableViewCell {

    var gameboard: UICollectionView?
    
    init?(style: UITableViewCellStyle, reuseIdentifier: String?, itemCount:Int) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.itemSize = GameboardCell.getItemSize(itemCount)

        gameboard = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        gameboard?.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        gameboard?.showsHorizontalScrollIndicator = false
        gameboard?.showsVerticalScrollIndicator = false
        gameboard?.backgroundColor = UIColor.whiteColor()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.redColor()
        self.contentView.addSubview(gameboard!)
        setGameboardContraints()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gameboard?.frame = self.contentView.bounds
    }
    
    func setCollectionViewDataSourceDelegate(viewController: (UICollectionViewDelegate, UICollectionViewDataSource), index:Int) {
        gameboard?.delegate = viewController.0
        gameboard?.dataSource = viewController.1
        gameboard?.tag = index
        gameboard?.reloadData()
    }
    
    func setGameboardContraints() {
        gameboard?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addConstraint(NSLayoutConstraint(item: gameboard!, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 12))
        self.addConstraint(NSLayoutConstraint(item: gameboard!, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 12))
        self.addConstraint(NSLayoutConstraint(item: gameboard!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 12))
        self.addConstraint(NSLayoutConstraint(item: gameboard!, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 12))
        self.addConstraint(NSLayoutConstraint(item: gameboard!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 296))
        self.addConstraint(NSLayoutConstraint(item: gameboard!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 296))
    }
    
    override func layoutIfNeeded() {
        setGameboardContraints()
        
        super.layoutIfNeeded()
        
    }
    
    private class func getItemSize(itemCount:Int) -> CGSize {
        var growthRatio = 1.25 + (CGFloat(itemCount / 5) * 0.25)
        let size = UIScreen.mainScreen().bounds.width/(CGFloat((itemCount - 1)/3) + growthRatio)
        return CGSizeMake(size, size);
    }
    
}
