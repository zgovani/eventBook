//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Zach Govani on 2/25/17.
//  Copyright © 2017 Zach Govani. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    var post: Post!
    var user: User!
    var profileImage: UIImageView!
    var posterText: UILabel!
    var postText: UITextView!
    var postDate: UILabel!
    var postTitle: UILabel!
    var likeButton: UIButton!
    var whoButton: UIButton!
    var tallyText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.darkBlue
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(
            [
                NSFontAttributeName : Constants.garamond,
                NSForegroundColorAttributeName : UIColor.darkGray
            ],
            for: .normal)
        
        setupProfileImage()
        setupPostTitle()
        setupPostDate()
        setupPosterText()
        setupPostText()
        setupLikeButton()
        setupWhoButton()
        setupTallyText()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupProfileImage() {
        profileImage = UIImageView(frame: CGRect(x: 20, y: (navigationController?.navigationBar.frame.maxY)! + 5, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40))
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.loadGif(name: "ajax-loader")
        post.getProfilePic(withBlock: { profImage in
            DispatchQueue.main.async {
                profileImage.image = profImage
                profileImage.contentMode = .scaleAspectFill
            }
        })
        view.addSubview(profileImage)
    }
    
    func setupPostTitle() {
        postTitle = UILabel(frame: CGRect(x: 10, y: profileImage.frame.maxY + 10, width: view.frame.width, height: 30))
        postTitle.textColor = UIColor.darkGray
        postTitle.font = Constants.garamond
        postTitle.font = postTitle.font.withSize(32)
        postTitle.adjustsFontForContentSizeCategory = true
        postTitle.text = post.title
        view.addSubview(postTitle)
    }
    
    func setupPostDate() {
        postDate = UILabel(frame: CGRect(x: 10, y: postTitle.frame.maxY + 10, width: view.frame.width, height: 30))
        postDate.textColor = UIColor.darkGray
        postDate.font = Constants.garamond
        postDate.font = postDate.font.withSize(20)
        postDate.adjustsFontForContentSizeCategory = true
        postDate.text = post.date
        view.addSubview(postDate)
    }
    
    func setupPosterText() {
        posterText = UILabel(frame: CGRect(x: 10, y: postDate.frame.maxY + 10, width: view.frame.width, height: 30))
        posterText.textColor = UIColor.darkGray
        posterText.font = Constants.garamond
        posterText.font = posterText.font.withSize(20)
        posterText.adjustsFontForContentSizeCategory = true
        posterText.text = post.poster
        view.addSubview(posterText)
    }
    
    func setupPostText() {
        postText = UITextView(frame: CGRect(x: 10, y: posterText.frame.maxY + 10, width: view.frame.width - 10, height: 50))
        postText.textColor = UIColor.darkGray
        postText.textAlignment = .left
        postText.backgroundColor = Constants.darkBlue
        postText.font = Constants.garamond
        postText.font = postText.font?.withSize(20)
        postText.adjustsFontForContentSizeCategory = true
        postText.isEditable = false
        postText.text = post.description
        view.addSubview(postText)
        
    }
    
    func setupLikeButton() {
        likeButton = UIButton(frame: CGRect(x: 10, y: postText.frame.maxY + 10, width: view.frame.width/2 - 10, height: 30))
        likeButton.titleLabel?.textAlignment = .left
        likeButton.setTitle("RSVP", for: .normal)
        likeButton.setTitleColor(UIColor.lightGray, for: .normal)
        likeButton.layer.borderWidth = 2.0
        likeButton.layer.cornerRadius = 3.0
        likeButton.layer.borderColor = UIColor.lightGray.cgColor
        likeButton.layer.masksToBounds = true
        likeButton.backgroundColor = Constants.skyBlue
        if post.likers.contains(user.id) {
            likeButton.setTitleColor(UIColor.darkGray, for: .normal)
            likeButton.layer.borderColor = UIColor.darkGray.cgColor
            likeButton.backgroundColor = Constants.darkBlue
        }
        likeButton.addTarget(self, action: #selector(DetailViewController.likeButtonPressed), for: .touchUpInside)
        view.addSubview(likeButton)
    }
    
    func setupWhoButton() {
        whoButton = UIButton(frame: CGRect(x: likeButton.frame.maxX, y: postText.frame.maxY + 10, width: view.frame.width/2 - 10, height: 30))
        whoButton.setTitle("Who is going?", for: .normal)
        whoButton.setTitleColor(UIColor.darkGray, for: .normal)
        whoButton.layer.borderWidth = 2.0
        whoButton.layer.cornerRadius = 3.0
        whoButton.layer.borderColor = UIColor.darkGray.cgColor
        whoButton.layer.masksToBounds = true
        whoButton.addTarget(self, action: #selector(DetailViewController.whoButtonPressed), for: .touchUpInside)
        view.addSubview(whoButton)
    }
    
    func setupTallyText() {
        tallyText = UILabel(frame: CGRect(x: 10, y: likeButton.frame.maxY + 10, width: view.frame.width/2 - 10, height: 30))
        tallyText.text = "There are " + String(self.post.likers.count) +  " people RSVP'd."
        tallyText.font = Constants.garamond
        tallyText.textColor = UIColor.darkGray
        tallyText.adjustsFontForContentSizeCategory = true
        tallyText.adjustsFontSizeToFitWidth = true
        view.addSubview(tallyText)
    }
    
    func likeButtonPressed() {
        if post.go == Post.goingStatus.notGoing {
            post.addInterestedUser(withId: user.id)
            likeButton.setTitleColor(UIColor.darkGray, for: .normal)
            likeButton.layer.borderColor = UIColor.darkGray.cgColor
            likeButton.backgroundColor = Constants.darkBlue
            tallyText.text = "There are " + String(self.post.likers.count) +  " people RSVP'd."
            post.go = Post.goingStatus.going
        }
    }
    
    func whoButtonPressed() {
        performSegue(withIdentifier: "toLikersFromDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLikersFromDetail" {
            let likerVC = segue.destination as! LikersViewController
            likerVC.post = post
        }
    }
}


