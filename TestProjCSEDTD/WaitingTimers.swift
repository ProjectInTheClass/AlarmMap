//
//  WaitingTimers.swift
//  TestProjCSEDTD
//
//  Created by 윤성우 on 2020/05/28.
//  Copyright © 2020 윤성우. All rights reserved.
//

import Foundation

func globalFunction() {
    print("Can?")
}

class WaitingTimers {
    
    let runLoop = RunLoop.current
    var timersArray = [Timer]()
    var tempTimer = Timer()
    
    init() {
        print("WaitingTimers Here!")
    }
    
    @objc func fireFunc() {
        print("Fire...")
        globalFunction()
    }
    func timerAppend() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireFunc), userInfo: nil, repeats: true)
        timersArray.append(Timer(fire: Date(timeIntervalSinceNow: 0.0), interval: 10.0, repeats: true, block: { tempTimer in
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
        let month = 1
        let day = 1
        let hour = 0
        let minute = 0
        let calendar = Calendar(identifier: .iso8601)
        let dataComp = DateComponents(calendar: Calendar(identifier: .iso8601), timeZone: TimeZone.current, era: 1, year: year, month: month, day: day, hour: hour, minute: minute, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        print()
        print(dataComp.date)
        print()
        
        let locNotManager = LocalNotificationManager()
        locNotManager.requestPermission()
        locNotManager.addNotification(title: "I'm Here!")
        locNotManager.scheduleNotifications()

    }
    
}

var waitingTimersRef = WaitingTimers()
