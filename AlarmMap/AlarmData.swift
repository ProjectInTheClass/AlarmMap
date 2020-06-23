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

let secondsPerDay: Double = 86400

// by CSEDTD - 월화수목금토일 --> 일월화수목금토
let dates = ["일", "월", "화", "수", "목", "금", "토"]

enum AheadOfTime {
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
    
    // by CSEDTD
    func toDouble() -> Double {
        switch self {
        case .none:
            return 0.0 * 60
        case .five:
            return 5.0 * 60
        case .fifteen:
            return 15.0 * 60
        case .thirty:
            return 30.0 * 60
        }
    }
}

class RouteAlarm{
    var time:Date // label에 띄우는 용도 + 요일 계산 용도
    // by CSEDTD
    var startTimer = Timer()
    let runLoop = RunLoop.current
    // var deadline: Date // 추가 기능 (지각 했을 때 notification 띄우는 용도)
    //var alarmIndex: Int // routeAlarmListTest의 index <-- 없앰
    var repeatDates:[Bool] = [false,false,false,false,false,false,false]
    var repeats: Bool = false
    var isOn = true
    var infoIsOn: Bool
    var aheadOf: AheadOfTime
    
    var route: [WayPoint]
    var routeIndex: Int = -1
    var alarmTimeDateFormatter = DateFormatter()
    
    // 0623
    var routeTitle: String
    var routeSubtitle: String?
    var routeTotalDisplacement: Double
    var routeTotalTime: Int
    
    var pathFindingTV:UITableView? = nil
    
    init() {
        self.time = Date()
        self.route = [WayPoint(placeholder: 0), WayPoint(placeholder: 1)]
        self.aheadOf = .none
        self.isOn = false
        self.infoIsOn = false
        self.routeTitle = ""
        self.routeSubtitle = nil
        self.routeTotalDisplacement = -1.0
        self.routeTotalTime = -1
    }
    // by CSEDTD
    init(time:Date, repeatDates: [Bool], aheadOf: AheadOfTime, route: [WayPoint], repeats: Bool, infoIsOn: Bool, routeTitle: String, routeSubtitle: String?, routeTotalDisplacement: Double, routeTotalTime: Int) {
        // by CSEDTD
        self.repeatDates = repeatDates
        self.repeats = repeats
        self.aheadOf = aheadOf
        // TODO
        self.route = dummyRouteInfo2.route //[kloongHouse, kloongGS25]
        //self.route = route
        self.infoIsOn = infoIsOn
        self.time = time
        if Date() >= self.time - self.aheadOf.toDouble() {
            self.time += secondsPerDay
            print("here")
        }
        self.routeTitle = routeTitle
        self.routeSubtitle = routeSubtitle
        self.routeTotalDisplacement = routeTotalDisplacement
        self.routeTotalTime = routeTotalTime
        // TODO - time setting (오전12시 요일 문제 해결되면 firedate 사용 가능)
        self.startTimer = Timer(fireAt: self.time /*- 경로 시간 TODO*/ - self.aheadOf.toDouble(), interval: /*5.0*/secondsPerDay, target: self, selector: #selector(alarmStarts), userInfo: nil, repeats: self.repeats)
        runLoop.add(self.startTimer, forMode: .default)
        self.startTimer.tolerance = 5.0
        
        self.alarmTimeDateFormatter.locale = Locale(identifier: "ko")
        self.alarmTimeDateFormatter.dateStyle = .none
        self.alarmTimeDateFormatter.timeStyle = .short
    }
    @objc func alarmStarts() {
        // by CSEDTD
        // TODO
        if !self.infoIsOn {
            print("self.infoIsOn == false")
            self.finished()
        } else if !self.isOn {
            print("self.isOn == false")
            self.detach()
        } else if workingAlarmExists {
            print("ERROR: 알람 시간대 중복! 알람 무시됨 (AlarmData.swift")
            scheduleNotifications(state: .blocked, sender: self)
        } else {
            print("타이머 정상 상태")
            
            let weekday: Int = Calendar(identifier: .iso8601).dateComponents([.weekday], from: self.time).weekday!
            
            if self.repeatDates[weekday - 1] {
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
                globalManager.showsBackgroundLocationIndicator = true // TODO - You so bad code...
            
                self.routeIndex = 0

                // TODO
                scheduleNotifications(state: .start, sender: self)

                workingAlarm = self
                workingAlarmExists = true
                // TODO
                currentDestination = self.getCurrentDestination()
                finalDestination = self.getFinalDestination()
                
                /*
                let locNotManager = LocalNotificationManager()
                locNotManager.requestPermission()
                locNotManager.addNotification(title: "길찾기 시작!")
                locNotManager.scheduleNotifications()
                 */

                // TODO
                notificationAlarm = NotificationAlarm(true)
            }
        }
        
        /* TODO - for test
        let locNotManager2 = LocalNotificationManager()
        locNotManager2.requestPermission()
        locNotManager2.addNotification(title: "5초 반복 타이머")
        locNotManager2.scheduleNotifications()
         */

        // print("Timer fired: " + String(workingAlarm.isOn) + " " + String(self.isOn))
        print(self.getTimeToString())
        
        self.time += secondsPerDay
    }
    
    // by CSEDTD
    func detach() {
        self.isOn = false
        if self == workingAlarm {
            finished()
        }
    }

    // by CSEDTD
    func finished() {
        currentDestination = Location()
        finalDestination = Location()
        workingAlarm = RouteAlarm()
        workingAlarmExists = false
        routeIndex = -1
        currentDistance = -1.0
        // TODO
        notificationAlarm.timer.invalidate()
                    
        // TODO - Big problem (background)
/*
        globalManager.stopUpdatingLocation()
        if headingAvailable {
            globalManager.stopUpdatingHeading()
        }
 */
        globalManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        globalManager.distanceFilter = CLLocationDistanceMax
        globalManager.showsBackgroundLocationIndicator = false // TODO - You so bad code...
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
    func getStartingPoint() -> Location {
        return self.route.first?.location ?? Location()
    }

    func getCurrentDestination() -> Location {
        for point in route {
            print(point.location.name)
        }
        print(route[routeIndex].location.name)
        return self.route[routeIndex].location
    }

    func getFinalDestination() -> Location {
        return self.route.last?.location ?? Location()
    }
}

// by CSEDTD
var currentDestination: Location = Location()
var finalDestination: Location = Location()
var workingAlarm: RouteAlarm = RouteAlarm()
var workingAlarmExists: Bool = false
// TODO
var notificationAlarm: NotificationAlarm = NotificationAlarm(false)

class NotificationAlarm {
    var timer = Timer()
    var currentRemainingTime: Double = -1.0
    
    init(_ bool: Bool) {
        if bool == true {
            // TODO - API 호출
            //currentRemainingTime =
            timer = Timer(timeInterval: 30.0, target: self, selector: #selector(makeNotificationIfUrgent), userInfo: nil, repeats: true)
        }
    }
    @objc func makeNotificationIfUrgent() {
        // TODO - API 호출
        //currentRemaingingTime =
        if currentRemainingTime <= 120.0 {
            let locNotManager = LocalNotificationManager()
            locNotManager.requestPermission()
            locNotManager.addNotification(title: "서두르세요! 버스/지하철이 2분 이내로 도착해요!")
            locNotManager.scheduleNotifications()
            timer.invalidate()
        }
        currentRemainingTime -= 30.0
    }
}

