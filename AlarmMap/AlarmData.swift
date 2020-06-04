//
//  AlarmData.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import Foundation

let dates = ["월", "화", "수", "목", "금", "토", "일"]

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
    var alarmIndex: Int // routeAlarmListTest의 index
    var repeatDates:[Bool] = [false,false,false,false,false,false,false]
    var isOn = true
    
    var aheadOf:AheadOfTime = .none
    
    var routeInfo:RouteInfo
    
    var alarmTimeDateFormatter = DateFormatter()
    
    // by CSEDTD
    init(time:Date, routeInfo:RouteInfo) {
        self.time = time
        // by CSEDTD
        // 나중에 알람 지울 때는 index+1에 해당하는 알람들의 self.alarmIndex를 모두 1 감소시켜야 함
        self.routeInfo = routeInfo
        self.alarmIndex = routeAlarmListTest.count
        routeAlarmListTest.append(self)
        self.startTimer = Timer(fireAt: time, interval: 10, target: self, selector: #selector(alarmStarts), userInfo: nil, repeats: true)
        runLoop.add(self.startTimer, forMode: .default)
        self.startTimer.tolerance = 5.0
        
        self.alarmTimeDateFormatter.locale = Locale(identifier: "ko")
        self.alarmTimeDateFormatter.dateStyle = .none
        self.alarmTimeDateFormatter.timeStyle = .short
    }
    @objc func alarmStarts() {
        globalManager.startUpdatingLocation()
        workingAlarmIndex = self.alarmIndex
        workingAlarmExists = true
        
        print(self.getTimeToString())
        self.time += 10
        
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
        return routeInfo.route.destinationPoint
    }
}


// by CSEDTD
var routeAlarmListTest: [RouteAlarm] = []
var workingAlarmIndex: Int = 0
var workingAlarmExists: Bool = false

