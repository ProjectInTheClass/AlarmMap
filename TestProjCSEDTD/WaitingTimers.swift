//
//  WaitingTimers.swift
//  TestProjCSEDTD
//
//  Created by 윤성우 on 2020/05/28.
//  Copyright © 2020 윤성우. All rights reserved.
//

import Foundation

class WaitingTimers {
    
    let runLoop = RunLoop.current
    var timersArray = [Timer]()
    var tempTimer = Timer()
    
    func timerAppend() {
        timersArray.append(Timer(fire: Date(timeIntervalSinceNow: 0.0), interval: 3.0, repeats: true, block: { tempTimer in
            self.fireMethod(tempTimer)
        }))
        runLoop.add(timersArray[timersArray.count-1], forMode: .default)
        timersArray.last?.tolerance = 1.0
    }

    func timerRemoved() {
        if !timersArray.isEmpty {
            timersArray[0].invalidate()
            timersArray.remove(at: 0)
        }
    }
    
    func fireMethod(_ timer: Timer) {
        print("My Date: \(timer.fireDate)")
        let calendar = Calendar(identifier: .iso8601)
        print(calendar.dateComponents([.calendar, .timeZone, .era, .year, .month, .day, .hour, .minute, .second, .nanosecond, .weekday, .weekdayOrdinal, .quarter, .weekOfMonth, .weekOfYear, .yearForWeekOfYear], from: timer.fireDate))
        
        test()
    }
    
    func test() {
        let year = 2020
        let month = 5
        let day = 28
        let hour = 19
        let minute = 46
        let calendar = Calendar(identifier: .iso8601)
        let dataComp = DateComponents(calendar: Calendar(identifier: .iso8601), timeZone: TimeZone.current, era: 1, year: year, month: month, day: day, hour: hour, minute: minute, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        print()
        print(dataComp.date)
        print()
    }
    
}

var waitingTimersRef = WaitingTimers()
