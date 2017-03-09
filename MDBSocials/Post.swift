//
//  Post.swift
//  FirebaseDemoWeek3
//
//  Created by Zach Govani on 2/13/17.
//  Copyright © 2017 Zach Govani. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Post {
    var description: String?
    var imageUrl: String?
    var posterId: String?
    var poster: String?
    var id: String!
    var likers: [String]!
    var image: UIImage?
    var title: String?
    var date: String?
    var go: goingStatus!
    
    enum goingStatus {
        case going
        case notGoing
    }
    
    init(id: String, postDict: [String:Any]) {
        self.id = id
        self.go = Post.goingStatus.notGoing
        if let text = postDict["description"] as? String {
            self.description = text
        }
        if let imageUrl = postDict["imageUrl"] as? String {
            self.imageUrl = imageUrl
        }
        if let posterId = postDict["posterId"] as? String {
            self.posterId = posterId
        }
        if let poster = postDict["poster"] as? String {
            self.poster = poster
        }
        if let likers = postDict["likers"] as? [String] {
            self.likers = likers
        } else {
            self.likers = []
        }
        if let title = postDict["title"] as? String {
            self.title = title
        }
        if let date = postDict["date"] as? String {
            self.date = date
        }
        
    }
    
    func getProfilePic(withBlock: @escaping (_ profileImage: UIImage) -> ()) {
        let storage = FIRStorage.storage().reference().child("profilepics/\((id)!)")
        storage.data(withMaxSize: 1 * 2048 * 2048) { data, error in
            if let error = error {
                print(error)
            } else {
                DispatchQueue.main.async {
                    withBlock(UIImage(data: data!)!)
                }
            }
        }
    }
    
    func addInterestedUser(withId: String) {
        let ref: FIRDatabaseReference = FIRDatabase.database().reference().child("Posts")
        self.likers.append(withId)
        let childUpdates = ["\(self.id!)/likers": self.likers!]
        ref.updateChildValues(childUpdates)
    }
}
