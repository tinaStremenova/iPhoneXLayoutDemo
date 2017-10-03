//
//  Appearence.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 02/10/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import UIKit

struct Appearence {
    static func setAppAppearence() {
        
        // Navigation bar
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().barTintColor = UIColor.STRV.red
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        // Tab bar
        UITabBar.appearance().tintColor = UIColor.STRV.red
        
        // Tool bar
        UIToolbar.appearance().tintColor = UIColor.STRV.red
        
    }
}

extension UIColor {
    
    enum STRV {
        static var red:UIColor { return UIColor(red: 239/255, green: 13/255, blue: 51/255, alpha: 1) }
        static var black:UIColor { return UIColor(red: 17/255, green: 21/255, blue: 23/255, alpha: 1) }
    }
}
