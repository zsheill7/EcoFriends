//
//  UIColorExtensions.swift
//  TutorMe
//
//  Created by Zoe on 12/24/16.
//  Copyright © 2017 Zoe Sheill. All rights reserved.
//

import Foundation


extension UIColor {
    class func alertViewBlue() -> UIColor {
        return UIColor(red:0.17, green:0.41, blue:0.74, alpha:1.0)
    }
    class func textGray() -> UIColor {
        return UIColor(red:0.51, green:0.57, blue:0.61, alpha:1.0)
    }
    class func newSkyBlue() -> UIColor {
        return UIColor(red:0.76, green:0.91, blue:0.95, alpha:1.0)
    }
    class func flatDarkBlue() -> UIColor {
        return UIColor(red:0.58, green:0.69, blue:0.76, alpha:1.0)
    }
    class func titleBlue() -> UIColor {
        return UIColor(netHex: 0x51679F)
    }
    class func backgroundBlue() -> UIColor {
        return UIColor(red:0.70, green:0.87, blue:0.88, alpha:1.0)
    }
    class func lightTeal() -> UIColor {
        return UIColor(netHex: 0x70CECF)
    }
    class func backgroundGreen() -> UIColor {
        //return UIColor(netHex: 0x90EE90)
        //return UIColor(netHex: 0xBCED91)
        //return UIColor(netHex: 0xC0D9AF)
       return UIColor(netHex: 0xA9C9A4) 
    }
    
    class func sliderGreen() -> UIColor {
        //return UIColor(netHex: 0x2E9D9F)
         //return UIColor(netHex: 0x36C9CC) //brighter blue
        return UIColor(netHex: 0x6CCED0)
    }
    class func pagingMenuGray() -> UIColor {
       // return UIColor.lightGray.lighten(byPercentage: 0.2)!
        return UIColor.titleBlue()
    }
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
}
