//
//  AlarmData.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import Foundation
import CoreLocation

// by CSEDTD
infix operator ==
func ==(lhs: RouteAlarm, rhs: RouteAlarm) -> Bool {
    return lhs.startTimer == rhs.startTimer
}

let secondsPerDay = 86400

// by CSEDTD - 월화수목금토일 --> 일월화수목금토
let dates = ["일", "월", "화", "수", "목", "금", "토"]

enum AheadOfTime{
    case none, five, fifteen, thirty
    
    func toString() ->String {
        switch self {
        case .none:
            return "정시"
        case .five:
            return "5분 전"
        case .fifteen:
            return "15분 전"
        case .thirty:
            return "30분 전"
        }
    }
}

class RouteAlarm{
    var time:Date
    // by CSEDTD
    var startTimer = Timer()
    let runLoop = RunLoop.current
    // var deadline: Date // 추가 기능 (지각 했을 때 notification 띄우는 용도)
    //var alarmIndex: Int // routeAlarmListTest의 index <-- 없앰
    var repeatDates:[Bool] = [false,false,false,false,false,false,false]
    var isOn = true
    // by CSEDTD
    var infoIsOn: Bool
    
    var aheadOf: AheadOfTime
    
    var route: Route
    
    var alarmTimeDateFormatter = DateFormatter()
    
    
    init() {
        self.time = Date()
        self.route = Route()
        self.aheadOf = .none
        self.infoIsOn = false
    }
    // by CSEDTD
    init(time:Date, repeatDates: [Bool], aheadOf: AheadOfTime, route: Route, repeats: Bool, infoIsOn: Bool) {
        self.time = time
        // by CSEDTD
        self.repeatDates = repeatDates
        self.aheadOf = aheadOf
        self.route = route
        self.infoIsOn = infoIsOn
        
        // TODO - interval: 86400
        self.startTimer = Timer(fireAt: time + 10, interval: 3, target: self, selector: #selector(alarmStarts), userInfo: nil, repeats: repeats)
        runLoop.add(self.startTimer, forMode: .default)
        self.startTimer.tolerance = 5.0
        
        self.alarmTimeDateFormatter.locale = Locale(identifier: "ko")
        self.alarmTimeDateFormatter.dateStyle = .none
        self.alarmTimeDateFormatter.timeStyle = .short
    }
    @objc func alarmStarts() {
        // by CSEDTD
        // TODO
        if (!self.isOn) || (!self.infoIsOn) {
            self.detach()
        } else if workingAlarmExists {
            print("ERROR: 알람 시간대 중복! 알람 무시됨 (AlarmData.swift")
        } else {
            print("타이머 정상 상태")
            
            // by CSEDTD - background
            // TODO
            /*
            globalManager.startUpdatingLocation()
            if headingAvailable {
                globalManager.startUpdatingHeading()
            }
             */
            globalManager.desiredAccuracy = kCLLocationAccuracyBest
            globalManager.distanceFilter = 5.0

            workingAlarm = self
            workingAlarmExists = true
            currentDestination = route.destinationPoint
        }
        
        let locNotManager = LocalNotificationManager()
        locNotManager.requestPermission()
        locNotManager.addNotification(title: "This is Timer Notification every 10 sec")
        locNotManager.scheduleNotifications()

        print("Timer fired: " + String(workingAlarm.isOn) + " " + String(self.isOn))
        print(self.getTimeToString())

        // TODO - 꺼질 때 time += 86400
        //self.time += 3

    }
    
    // by CSEDTD
    func detach() {
        self.isOn = false
        if self == workingAlarm {
            finished()
        }
    }

    func finished() {
        currentDestination = Location()
        workingAlarm = RouteAlarm()
        workingAlarmExists = false
                    
        // TODO - Big problem (background)
/*
        globalManager.stopUpdatingLocation()
        if headingAvailable {
            globalManager.stopUpdatingHeading()
        }
 */
        globalManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        globalManager.distanceFilter = CLLocationDistanceMax
    }
    
    func event(){
        //do Something about route finding
    }
    
    func getRepeatDatesToString() -> String{
        var repeatDatesString:String = ""
        for (index,doesRepeat) in repeatDates.enumerated(){
            if(doesRepeat){
                repeatDatesString += "\(dates[index]) "
            }
        }
        
        return repeatDatesString
    }
    
    func getTimeToString() -> String{
        return self.alarmTimeDateFormatter.string(from: self.time)
    }
    
    // by CSEDTD
    func getDestination() -> Location {
        return route.destinationPoint
    }
}


// by CSEDTD
var currentDestination: Location = Location()
var workingAlarm: RouteAlarm = RouteAlarm()
var workingAlarmExists: Bool = false

