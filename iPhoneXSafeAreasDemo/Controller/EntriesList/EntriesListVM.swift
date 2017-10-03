//
//  EntriesListVM.swift
//  iPhoneXSafeAreasDemo
//
//  Created by Martina Stremenova on 29/09/2017.
//  Copyright © 2017 STRV. All rights reserved.
//

import Foundation

typealias EntryGroup = (dayDate:Date, entries: [NamedTimeEntry])

struct EntriesListVM {
    
    private lazy var entryDateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    private lazy var sectionTitleDateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    private lazy var items:[EntryGroup] = {
        
        let entries:[NamedTimeEntry] = DataManager.sharedInstance.getTimeEntries()
        
        let dates = entries.flatMap { $0.timeEntry.dateTime }
        let uniqueDatesByDay = dates.reduce([], { initialValue, date in
            initialValue.contains( where: { Calendar.current.isDate(date, inSameDayAs:$0) }) ? initialValue : initialValue + [date]
        })
        
        var entryGroups:[EntryGroup] = []
        uniqueDatesByDay.forEach { date in
            
            let filteredEntries = entries.filter { Calendar.current.isDate($0.timeEntry.dateTime, inSameDayAs: date )}
            entryGroups.append((dayDate: date, entries: filteredEntries.sorted { $0.timeEntry.dateTime > $1.timeEntry.dateTime }))
        }
        return entryGroups
    }()
    
    var sections:Int {
        mutating get { return self.items.count }
    }
    
    mutating func numberOfItems(inSection section:Int) -> Int {
        return self.items[section].entries.count
    }
    
    mutating func text(at indexPath:IndexPath) -> String {
        let item = self.items[indexPath.section].entries[indexPath.row]
        return item.name + "\n" + item.timeEntry.type.rawValue + ": " + self.entryDateFormatter.string(from: item.timeEntry.dateTime)
    }
    
    mutating func title(forSection section:Int) -> String {
        return self.sectionTitleDateFormatter.string(from: self.items[section].dayDate)
    }
}

