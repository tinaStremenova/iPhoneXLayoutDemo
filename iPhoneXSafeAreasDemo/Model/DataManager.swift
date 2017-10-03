//
//  APIManager.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 29/09/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

class DataManager {
    
    static let sharedInstance = DataManager()
    private init() {}
    
    //https://baconipsum.com/
    private lazy var items:[Item] = {
        
        let timeEntries = self._generateSortedTimeEntries()
        
        return [Item(itemName: "Ryan Reynolds",
                     itemDescription: "Has the best cat toys.",
                     itemPictureName: "cat-tie-1",
                     timeEntries: timeEntries),
                
                Item(itemName: "George Clooney",
                     itemDescription: "Bacon ipsum dolor amet chuck hamburger ribeye landjaeger doner pork belly beef porchetta.",
                     itemPictureName: "icon-placeholder",
                     timeEntries: timeEntries.map {
                        var mutableTimeEntry = $0
                        mutableTimeEntry.dateTime = $0.dateTime.addingTimeInterval(2*60)
                        return mutableTimeEntry }),
                
                Item(itemName: "Julia Roberts",
                     itemDescription: "Old and wise kitty.",
                     itemPictureName: "cat-tie-3",
                     timeEntries: timeEntries.map {
                        var mutableTimeEntry = $0
                        mutableTimeEntry.dateTime = $0.dateTime.addingTimeInterval(5*60)
                        return mutableTimeEntry }),
                
                Item(itemName: "Morgan Freeman",
                     itemDescription: "Employee of the month. Very fluffy. Likes long walks on the beach. ",
                     itemPictureName: "cat-tie-4",
                     timeEntries: timeEntries.map {
                        var mutableTimeEntry = $0
                        mutableTimeEntry.dateTime = $0.dateTime.addingTimeInterval(10*60)
                        return mutableTimeEntry }),
                
                Item(itemName: "Lindsay Lohan",
                     itemDescription: "American actress and singer. Lohan began her career as a child fashion model when she was three, and was later featured on the soap opera Another World for a year when she was 10.",
                     itemPictureName: "cat-tie-5",
                     timeEntries: timeEntries.map {
                        var mutableTimeEntry = $0
                        mutableTimeEntry.dateTime = $0.dateTime.addingTimeInterval(12*60)
                        return mutableTimeEntry }),
                
                Item(itemName: "Matt Damon",
                     itemDescription: "He's a good boy. Pork tenderloin pork chop, swine flank pig burgdoggen prosciutto filet mignon strip steak ball tip.",
                     itemPictureName: "cat-tie-2",
                     timeEntries: timeEntries.map {
                        var mutableTimeEntry = $0
                        mutableTimeEntry.dateTime = $0.dateTime.addingTimeInterval(20*60)
                        return mutableTimeEntry })]
        
    }()
    
    func getItems() -> [Item] {
        return self.items
    }
    
    func getTimeEntries() -> [NamedTimeEntry] {
        return self.items.flatMap{ item in
            item.timeEntries.flatMap({ (name: item.itemName, entries: $0) })
        }
    }
    
    private func _generateSortedTimeEntries() -> [TimeEntry] {
        
        let timeEntriesStrings = [
            "11-Sep-2017 02:28:33",
            "05-Sep-2017 02:57:43",
            "17-Sep-2017 09:27:36",
            "17-Sep-2017 09:04:12",
            "05-Sep-2017 23:03:36",
            "09-Sep-2017 10:53:34",
            "12-Sep-2017 02:06:39",
            "12-Sep-2017 18:43:06",
            "07-Sep-2017 10:56:46",
            "05-Sep-2017 23:05:47",
            "01-Sep-2017 04:58:57",
            "07-Sep-2017 02:28:55"
        ]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy H:mm:ss"
        
        var timeEntries: [TimeEntry] = []
        
        for (index, dateString) in timeEntriesStrings.enumerated() {
            timeEntries.append((type: (index % 2 == 0) ? .departure : .arrival, dateTime: dateFormatter.date(from: dateString)!))
        }
        
        timeEntries.sort(by: { $0.dateTime > $1.dateTime })
        
        return timeEntries
    }
}
