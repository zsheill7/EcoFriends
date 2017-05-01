//
//  Food.swift
//  EcoFriends
//
//  Created by Zoe on 4/29/17.
//  Copyright © 2017 CosmicMind. All rights reserved.
//

import UIKit
import Firebase

struct Food {
    
    let uid:String
    let description: String
    let title: String
    let location: String
    let price: Double
    let produceType: [String]
    let userID: String
    let userName: String
    
    
    
    init (snapshot:FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as? NSDictionary
        let channelSnapshot = snapshot.childSnapshot(forPath: "channels")
        // let channelValue = channelChild.value as? NSDictionary
        
       
        
        
        if let userUID = snapshot.key as? String {
            uid = userUID
        } else {
            uid = ""
        }
        
        if let location = snapshotValue?["location"] as? String {
            self.location = location
        } else {
            self.location = ""
        }
        
        if let price = snapshotValue?["price"] as? Double {
            self.price = price
        } else {
           self.price  = 5.0
        }
        
        if let title = snapshotValue?["title"] as? String {
            self.title = title
        } else {
            self.title = ""
        }
        if let produceType = snapshotValue?["producetype"] as? [String] {
            self.produceType = produceType
        } else {
            self.produceType = ["None"]
        }
        
        if let userID = snapshotValue?["userID"] as? String {
            self.userID = userID
        } else {
            self.userID = ""
        }
        
        if let userName = snapshotValue?["userName"] as? String {
            self.userName = userName
        } else {
            self.userName = ""
        }

        
        if let userDescription = snapshotValue?["description"] as? String {
            description = userDescription
        } else {
            description = ""
        }
    }
}
