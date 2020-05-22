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
    var repeatDates:[Bool] = [false,false,false,false,false,false,false]
    var isOn = true
    
    var aheadOf:AheadOfTime = .none
    
    var routeInfo:RouteInfo
    
    var alarmTimeDateFormatter = DateFormatter()
    
    init(time:Date, routeInfo:RouteInfo) {
        self.time = time
        self.routeInfo = routeInfo
        self.alarmTimeDateFormatter.locale = Locale(identifier: "ko")
        self.alarmTimeDateFormatter.dateStyle = .none
        self.alarmTimeDateFormatter.timeStyle = .short
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
}
