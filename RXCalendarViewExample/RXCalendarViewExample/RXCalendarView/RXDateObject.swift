//
//  RXDateObject.swift
//  RXCalendarViewExample
//
//  Created by AlphaDog on 2018/3/20.
//  Copyright © 2018年 AlphaDog. All rights reserved.
//

import UIKit

open class RXDateObject: NSObject {
    
    open var dateDayStr: String = ""
    open var dateStr: String = ""
    open var isToday: Bool = false
    open var isInCurrentMonth: Bool = true
    open var isSign: Bool = false
    
    convenience init(date: String, day: String, inCurrentMonth: Bool = true, today: Bool = false) {
        self.init()
        dateDayStr = day
        dateStr = date
        isToday = today
        isInCurrentMonth = inCurrentMonth
    }

}
