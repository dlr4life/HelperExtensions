//
//  Event.swift
//  XtraCredit
//
//  Created by DLR on 10/17/20.
//  Copyright © 2020 DLR. All rights reserved.
//

import UIKit

class Event {
    
    var events: [String]
    var date: [Date]
    let userDefaults = UserDefaults(suiteName: "group.com.suttonreed.XtraCredit")
    
    init() {
        self.events = userDefaults!.object(forKey: "events") as? [String] ?? [String]()
        self.date = userDefaults!.object(forKey: "date") as? [Date] ?? [Date]()
    }
}
