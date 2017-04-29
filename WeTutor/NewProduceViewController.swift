//
//  CreateNewProduce.swift
//  EcoFriends
//
//  Created by Zoe on 4/29/17.
//  Copyright © 2017 CosmicMind. All rights reserved.
//


import UIKit
import Eureka
import Material
import SCLAlertView
import Firebase
import FirebaseDatabase
import CoreLocation
import NVActivityIndicatorView
import FirebaseAnalytics
import NVActivityIndicatorView
import Popover





class NewProduceViewController : FormViewController, NVActivityIndicatorViewable {
    var ref: FIRDatabaseReference!
    
    func displayAlert(_ title: String, message: String) {
        SCLAlertView().showInfo(title, subTitle: message)
        
    }
    
    let cols = 4
    let rows = 8
    var cellWidth = 2
    var cellHeight = 2
    
    struct Static {
        static let nameTag = "name"
        static let passwordTag = "password"
        static let lastNameTag = "lastName"
        static let zipcodeTag = "zipcode"
        static let emailTag = "email"
        static let schoolTag = "school"
        static let phoneTag = "phone"
        static let enabled = "enabled"
        static let check = "check"
        static let segmented = "segmented"
        static let gender = "gender"
        static let birthday = "birthday"
        static let subjects = "subjects"
        static let button = "button"
        static let stepper = "stepper"
        static let slider = "slider"
        static let textView = "textview"
    }
    
    
    override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    typealias Emoji = String
    var currentUserIsTutor: Bool?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendSystem.system.getCurrentUser {_ in
            let currentUser = FriendSystem.system.currentUser
            if currentUser != nil {
                self.currentUserIsTutor = currentUser?.isTutor
            }
            
        }
        
        navigationAccessoryView = NavigationAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        print("self.currentUserIsTutor \(self.currentUserIsTutor)")
        self.loadForm()
        
    }
    
    func loadForm() {
        form
            
            +++ Section("")
            
            
        
            <<< TextRow("Title").cellSetup { cell, row in
               // cell.textField.title = row.tag
                row.title = row.tag
                cell.textField.placeholder = "10 Cans of Beans"//row.tag
            }
            
            <<< TextRow("Location").cellSetup {
                
                $1.title = $0.row.tag
                $1.cell.textField.placeholder = "Address"//$0.row.tag
            }
            
             +++ Section("")
           
            <<< DecimalRow("Price") {
                $0.useFormatterDuringInput = true
                $0.title = "Hourly Price"
                $0.placeholder = "$17.00"
                let formatter = CurrencyFormatter()
                formatter.locale = .current
                formatter.numberStyle = .currency
                $0.formatter = formatter
                if currentUserIsTutor != nil {
                    $0.hidden = .function([""], { form -> Bool in
                        return !self.currentUserIsTutor!
                    })
                    
                } else {
                    $0.hidden = false
                }
            }
            
            
             
             <<< MultipleSelectorRow<Emoji>("producetype") {
             $0.title = "Produce Type"
             $0.tag = "producetype"
             $0.options = produceTypes
             $0.value = ["Grain"]
             }
             .onPresent { from, to in
             to.view.backgroundColor = UIColor.backgroundBlue()
             to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(self.multipleSelectorDone(_:)))
             }
            
            +++ Section("")
            
           

            /*
             <<< TextRow("gpa") {
             $0.title = "GPA (4.0 scale)"
             $0.tag = "gpa"
             $0.placeholder = "3.6"
             if currentUserIsTutor != nil {
             if currentUserIsTutor == true {
             $0.hidden = false
             } else {
             $0.hidden = true
             }
             
             } else {
             $0.hidden = false
             }
             }*/
            
            <<< TextAreaRow("description") {
                $0.placeholder = "Description"
                $0.tag = "description"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 90)
                }.cellSetup({ (cell, row) in
                    cell.backgroundColor = UIColor.clear
                    
                    
                    cell.textView.backgroundColor = UIColor.clear
                })
            
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Continue"
                }
                .onCellSelection { cell, row in
                    print("here0")
                    let size = CGSize(width: 30, height:30)
                    
                    self.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: 6)!)
                    
                    self.continueSelected()
        }
    }
    
    func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func continueSelected() {
        print("here1")
        let row1: TextRow? = self.form.rowBy(tag: "Title")
        let title = row1?.value
        
        /* let row2: TextRow? = self.form.rowBy(tag: "school")
         let school = row2?.value*/
        let row3: TextRow? = self.form.rowBy(tag: "Location")
        let location = row3?.value
        
        let row4: DecimalRow? = self.form.rowBy(tag: "Price")
        let price = row4?.value
        //let row5: PickerInlineRow<String>? = self.form.rowBy(tag: "grade")
      //   let grade = row5?.value
        
        
         let row6: MultipleSelectorRow<Emoji>? = self.form.rowBy(tag: "producetype")
         let producetype = row6?.value
         
         var produceArray: [String]?
         if producetype != nil {
            produceArray = Array(producetype!)
         }
        let row7: TextAreaRow? = self.form.rowBy(tag: "description")
        let description = row7?.value
        
        /* let row8: TextRow? = self.form.rowBy(tag: "gpa")
         let gpa = row8?.value*/
        
        if title != nil, location != nil {
            
            self.ref = FIRDatabase.database().reference()
            
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(description, forKey: "description")
            let user = FIRAuth.auth()?.currentUser
            
            let userID = UUID().uuidString
            
            let destUserID = FIRAuth.auth()?.currentUser
            
         /*   self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                print("got snapshot")
                
                let value = snapshot.value as? NSDictionary
                print("value?[name] as? String \(value?["name"] as? String)")
                print("value?[password] as? String \(value?["password"] as? String)")
                print("value?[email] as? String \(value?["email"] as? String)")
                print("value?[isTutor] as? String \(value?["isTutor"] as? Bool)")
                if let name = value?["name"] as? String,
                    let password = value?["password"] as? String,
                    let email = value?["email"] as? String {
                    
                    
                    
                    let size = CGSize(width: 30, height:30)
                    
                    */
                    
                    //self.ref.child("users/\(userID!)/zipcode").setValue(zipcode)
                    // self.ref.child("users/\(userID!)/schoolName").setValue(school)
                    self.ref.child("food/\(userID)/title").setValue(title)
                    self.ref.child("food/\(userID)/location").setValue(location)
                    self.ref.child("food/\(userID)/price").setValue(price)
                    self.ref.child("food/\(userID)/producetype").setValue(producetype)
                    /*self.ref.child("users/\(userID!)/grade").setValue(grade)
                     self.ref.child("users/\(userID!)/preferredSubject").setValue(subjectArray)*/
                    self.ref.child("food/\(userID)/description").setValue(description)
                    self.ref.child("food/\(userID)/userID").setValue(destUserID)
                    /* self.ref.child("users/\(userID!)/gpa").setValue(gpa)
                     
                     FIRAnalytics.setUserPropertyString(school, forName: "school")*/
                    //FIRAnalytics.setUserPropertyString(gender, forName: "gender")
                    /*  FIRAnalytics.setUserPropertyString(grade, forName: "grade")
                     FIRAnalytics.setUserPropertyString(gpa, forName: "gpa")
                     
                     for subject in subjectArray! {
                     FIRAnalytics.setUserPropertyString(subject, forName: "preferred_subject")
                     }*/
                    
                    
                    print("error=nil")
                    let geocoder = CLGeocoder()
                   /* geocoder.geocodeAddressString(zipcode!) { placemarks, error in
                        if error != nil {
                            print(error?.localizedDescription ?? "")
                        } else {
                            for placemark in placemarks! {
                                let location = placemark.location
                                let latitude = location?.coordinate.latitude
                                let longitude = location?.coordinate.longitude
                                self.ref.child("users/\(userID!)/latitude").setValue(latitude)
                                self.ref.child("users/\(userID!)/longitude").setValue(longitude)
                            }
                        }
                    }*/
                    self.stopAnimating()
                    
                    self.performSegue(withIdentifier: "toSecondVC", sender: self)
                    
                    
             /*   } else {
                    self.displayAlert("You are not signed in", message: "Please log in again")
                    self.stopAnimating()
                }*/
                
                
                // ...
           /* }) { (error) in
                self.displayAlert("Error", message: error.localizedDescription)
                self.stopAnimating()
                
            }
            */
            
            
        
            
        } else {
            self.displayAlert("Error", message: "Please fill out every section.")
            self.stopAnimating()
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = UIColor(white: 1, alpha: 0.0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        self.tableView?.tableFooterView = UIView()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 1.0)
    }
    
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}





