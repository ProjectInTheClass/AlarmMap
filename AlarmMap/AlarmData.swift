//
//  AlarmData.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import Foundation

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
    
    var aheadOf: AheadOfTime
    
    var route: Route
    
    var alarmTimeDateFormatter = DateFormatter()
    
    init() {
        self.time = Date()
        self.route = Route()
        self.aheadOf = .none
    }
    // by CSEDTD
    init(time:Date, repeatDates: [Bool], aheadOf: AheadOfTime, route: Route, repeats: Bool) {
        self.time = time
        // by CSEDTD
        self.repeatDates = repeatDates
        self.aheadOf = aheadOf
        self.route = route
        // TODO - interval: 86400
        self.startTimer = Timer(fireAt: time, interval: 10, target: self, selector: #selector(alarmStarts), userInfo: nil, repeats: true)
        runLoop.add(self.startTimer, forMode: .default)
        self.startTimer.tolerance = 5.0
        
        self.alarmTimeDateFormatter.locale = Locale(identifier: "ko")
        self.alarmTimeDateFormatter.dateStyle = .none
        self.alarmTimeDateFormatter.timeStyle = .short
    }
    @objc func alarmStarts() {
        // by CSEDTD
        print(workingAlarm.isOn)
        
        let locNotManager = LocalNotificationManager()
        locNotManager.requestPermission()
        locNotManager.addNotification(title: "This is Timer Notification every 10 sec")
        locNotManager.scheduleNotifications()
        print("Timer fired")


        if !workingAlarmExists && self.isOn {
            globalManager.startUpdatingLocation()
            workingAlarm = self
            workingAlarmExists = true
            currentDestination = route.destinationPoint
            
            // TODO - 꺼질 때 time += 86400
            print(self.getTimeToString())
            self.time += 10
        }
        else {
            print("ERROR: 알람 시간대 중복! 알람 무시됨 (AlarmData.swift")
        }
        
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

