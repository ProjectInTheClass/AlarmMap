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
        timersArray.append(Timer(fire: Date(timeIntervalSinceNow: 5.0), interval: 3.0, repeats: true, block: { tempTimer in
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
    }
    
}

var waitingTimersRef = WaitingTimers()
