//
//  PostCollectionViewCell.swift
//  FirebaseDemoWeek3
//
//  Created by Zach Govani on 2/13/17.
//  Copyright © 2017 Zach Govani. All rights reserved.
//

import UIKit
import Firebase

class PostCollectionViewCell: UICollectionViewCell {
    var post: Post!
    var profileImage: UIImageView!
    var title: UILabel!
    var poster: UILabel!
    var numRSVP: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gradient = CAGradientLayer()
        gradient.frame = contentView.bounds
        let blue1: UIColor = UIColor(red:0.51, green:0.70, blue:0.82, alpha:1.0)
        let blue2: UIColor = UIColor(red:0.94, green:0.97, blue:1.00, alpha:1.0)
        gradient.colors = [blue2.cgColor, blue1.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        contentView.layer.insertSublayer(gradient, at: 0)
        setupProfileImage()
        setupTitle()
        setupPoster()
        setupNumRSVP()
    }
    
    func setupProfileImage() {
        profileImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width / 2, height: self.frame.height))
        profileImage.clipsToBounds = true
        contentView.addSubview(profileImage)
    }
    
    func setupTitle() {
        title = UILabel(frame: CGRect(x: profileImage.frame.maxX + 10, y: 10, width: self.frame.width/2 - 10, height: 30))
        title.textColor = UIColor.darkGray
        title.font = UIFont(name: "Garamond", size: 25)
        contentView.addSubview(title)
    }
    
    func setupPoster() {
        poster = UILabel(frame: CGRect(x: profileImage.frame.maxX + 10, y: title.frame.maxY + 10, width: self.frame.width/2 - 10, height: 13))
        poster.textColor = UIColor.darkGray
        poster.font = UIFont(name: "Garamond", size: 15)
        poster.adjustsFontForContentSizeCategory = true
        contentView.addSubview(poster)
        
    }
    
    func setupNumRSVP() {
        numRSVP = UILabel(frame: CGRect(x: profileImage.frame.maxX + 10, y: contentView.frame.height-30, width: self.frame.width/2 - 10, height: 20))
        numRSVP.textColor = UIColor.darkGray
        numRSVP.font = UIFont(name: "Garamond", size: 15)
        numRSVP.adjustsFontForContentSizeCategory = true
        contentView.addSubview(numRSVP)
        
    }
    
}
