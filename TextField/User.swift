//
//  User.swift
//  TutorMe
//
//  Created by Zoe on 12/22/16.
//  Copyright © 2016 CosmicMind. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct User {
    let uid:String
    let email:String
    let name:String
    let isTutor: Bool
    let age: Int
    let description: String
    let phone: String
    let address:String
    let school: String
    
    let languages: [String]
    let availableDays: [String]
    let preferredSubjects: [String]
    
    let availabilityInfo: String
    let grade: String
    
    let latitude: CGFloat
    let longitude: CGFloat
    
    let channels: [String: String]
    /*
     
     uid
     name
     age
     description
     isTutor
     languages
     address
     availableDays
     school
 
 */
    
    init(userData:FIRUser) {
        uid = userData.uid
        name = ""
        age = 0
        description = userData.description
        isTutor = false
        languages = [""]
        address = ""
        availableDays = [String]()
        school = ""
        phone = ""
        preferredSubjects = [String]()
        availabilityInfo = ""
        grade = ""
        latitude = 0
        longitude = 0
        channels = [String:String]()
        if let mail = userData.providerData.first?.email {
            email = mail
        } else {
            email = ""
        }
    }
    
    init (snapshot:FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        
        if let userUID = snapshot.key as? String {
            uid = userUID
        } else {
            uid = ""
        }
        
        if let userEmail = snapshotValue?["email"] as? String {
            email = userEmail
        } else {
           email = ""
        }
        
        if let userAddress = snapshotValue?["address"] as? String {
            address = userAddress
        } else {
            address  = ""
        }
        
        if let userName = snapshotValue?["name"] as? String {
            name = userName
        } else {
            name = ""
        }
        
        if let userDescription = snapshotValue?["description"] as? String {
            description = userDescription
        } else {
            description = ""
        }
        
        if let userIsTutor = snapshotValue?["isTutor"] as? Bool {
            isTutor = userIsTutor
        } else {
            isTutor = false
        }
        
        if let userLanguages = snapshotValue?["languages"] as? [String] {
            languages = userLanguages
        } else {
            languages = [""]
        }
        
        if let userAvailableDays = snapshotValue?["availableDays"] as? [String] {
            availableDays = userAvailableDays
        } else {
            availableDays = [String]()
        }
        
        if let userSchool = snapshotValue?["school"] as? String {
            school = userSchool
        } else {
            school = ""
        }
        if let userAge = snapshotValue?["age"] as? Int {
            age = userAge
        } else {
            age = 0
        }
        if let userPhone = snapshotValue?["phone"] as? String {
            phone = userPhone
        } else {
            phone = ""
        }
        if let userSubject = snapshotValue?["preferredSubject"] as? [String] {
            preferredSubjects = userSubject
        } else {
            preferredSubjects = ["None"]
        }
        
        if let userAvailability = snapshotValue?["availabilityInfo"] as? String {
            availabilityInfo = userAvailability
        } else {
            availabilityInfo = ""
        }
        
        
        if let userLatitude = snapshotValue?["latitude"] as? CGFloat {
            latitude = userLatitude
        } else {
            latitude = 0
        }
        if let userLongitude = snapshotValue?["longitude"] as? CGFloat {
            longitude = userLongitude
        } else {
            longitude = 0
        }
        if let userChannels = snapshotValue?["channels"] as? [String:String] {
            channels = userChannels
        } else {
            channels = [String:String]()
        }
        if let userGrade = snapshotValue?["grade"] as? String {
            grade = userGrade
        } else {
            grade = ""
        }
        
    }
    
    init (uid: String, email: String, name: String, school: String, isTutor: Bool, address: String, age: Int, description: String, languages: [String], availableDays: [String], phone: String, preferredSubjects: [String], channels: [String:String], availabilityInfo: String, latitude: CGFloat, longitude: CGFloat, grade: String) {
        self.uid = uid
        self.email = email
        self.address = address
        self.name = name
        self.age = age
        self.description = description
        self.isTutor = isTutor
        self.languages = languages
        self.availableDays = availableDays
        self.school = school
        self.phone = phone
        self.preferredSubjects = preferredSubjects
        self.channels = channels
        self.availabilityInfo = availabilityInfo
        self.latitude = latitude
        self.longitude = longitude
        self.grade = grade
    }
}
