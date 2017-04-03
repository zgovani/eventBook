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
        setupGradient()
        setupProfileImage()
        setupTitle()
        setupPoster()
        setupNumRSVP()
    }
    
    func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.colors = [Constants.lightBlue.cgColor, Constants.darkBlue.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0)
        contentView.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupProfileImage() {
        profileImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width / 2, height: self.frame.height))
        profileImage.clipsToBounds = true
        contentView.addSubview(profileImage)
    }
    
    func setupTitle() {
        title = UILabel(frame: CGRect(x: profileImage.frame.maxX + 10, y: 10, width: self.frame.width/2 - 10, height: 30))
        title.textColor = UIColor.darkGray
        title.font = Constants.garamond
        contentView.addSubview(title)
    }
    
    func setupPoster() {
        poster = UILabel(frame: CGRect(x: profileImage.frame.maxX + 10, y: title.frame.maxY + 10, width: self.frame.width/2 - 10, height: 20))
        poster.textColor = UIColor.darkGray
        poster.font = Constants.garamond
        poster.adjustsFontSizeToFitWidth = true
        poster.font = poster.font.withSize(20)
        contentView.addSubview(poster)
        
    }
    
    func setupNumRSVP() {
        numRSVP = UILabel(frame: CGRect(x: profileImage.frame.maxX + 10, y: contentView.frame.height-30, width: self.frame.width/2 - 10, height: 20))
        numRSVP.textColor = UIColor.darkGray
        numRSVP.font = Constants.garamond
        numRSVP.adjustsFontSizeToFitWidth = true
        numRSVP.font = numRSVP.font.withSize(20)
        contentView.addSubview(numRSVP)
        
    }
    
}
