//
//  ItemListVM.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 26/09/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation


struct ItemListVM {
    
    lazy var items:[Item] = {
            return DataManager.sharedInstance.getItems()    
    }()
    
    lazy var entryDateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-Y H:mm:ss"
        return formatter
    }()
    
    var tabbarItemTitle:String {
        return "Employees"
    }
    
}
