//
//  Item.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 29/09/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation


enum EntryType:String {
    case arrival = "Arrival"
    case departure = "Departure"
}

typealias TimeEntry = (type:EntryType, dateTime:Date)
typealias NamedTimeEntry = (name:String, timeEntry:TimeEntry)

struct Item {
    var itemName: String
    var itemDescription: String
    var itemPictureName: String
    var timeEntries:[TimeEntry]
}
