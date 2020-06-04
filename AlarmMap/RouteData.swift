//
//  Route.swift
//  TableViewPractice
//
//  Created by 김요환 on 2020/04/23.
//  Copyright © 2020 Kloong. All rights reserved.

import Foundation

struct RouteCategory{
    var title: String
    var routeInfoList: [RouteInfo]
}

class RouteInfo{
    var title : String
    var subtitle: String
    
    var route: Route // 얘는 string이 아니라 실제 경로에 대한 정보를 담고 있어야 한다.
    var routeAlarmList:[RouteAlarm]
    var routeAlarmIsOn = true
    
    // by CSEDTD - 추가 기능으로 빼 두자
    var scheduledDate: Date

    //임시 init
    init(){
        self.title = "이름"
        self.subtitle = "설명"
        self.route = Route()
        self.routeAlarmList = [RouteAlarm]()
        self.scheduledDate = Date()
    }
    
    // by CSEDTD
    init(title: String, subtitle: String?, route: Route, scheduledDate: Date) {
        self.title = title
        self.subtitle = subtitle ?? ""
        self.route = route
        self.routeAlarmList = [RouteAlarm]()
        self.scheduledDate = scheduledDate
    }
    
    // by CSEDTD
    func addAlarm(time: Date, repeatDates: [Bool], aheadOf: AheadOfTime) {
        self.routeAlarmList.append(RouteAlarm(time: time, repeatDates: repeatDates, aheadOf: aheadOf, route: self.route, repeats: true))
    }

}

class Route{
    // by CSEDTD
    var startingPoint: Location
    var destinationPoint: Location

    var somethingNeed: String
    //실제 경로(버스, 지하철, 출발지, 도착지 등)
    
    //임시 init
    init() {
        // by CSEDTD
        self.startingPoint = Location(title: "startTest", latitude: 37.0, longitude: 129.0)
        self.destinationPoint = Location(title: "destTest", latitude: 37.1, longitude: 129.1)
        self.somethingNeed = ""
    }
    
    // by CSEDTD
    init(from start: Location, to dest: Location, additionalInfo: String) {
        self.startingPoint = start
        self.destinationPoint = dest
        self.somethingNeed = additionalInfo
    }
}

// by CSEDTD
struct Location {
    var title: String // ex 학교, 회사, 집, ...
    var latitude: Double
    var longitude: Double
    
    init() {
        self.title = ""
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(title: String, latitude: Double, longitude: Double) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func toString() -> String {
        return self.title
    }
}

//enum DateEnum{
//    case mon, tue, wed, thu, fri, sat, sun
//
//    func toString() -> String{
//        switch  self {
//        case .mon:
//            return "월"
//        case .tue:
//            return "화"
//        case .wed:
//            return "수"
//        case .thu:
//            return "목"
//        case .fri:
//            return "금"
//        case .sat:
//            return "토"
//        case .sun:
//            return "일"
//        }
//    }
//}

//class RepetitionDate{
//    var repetitionDateFlags:[DateEnum:Bool] = [.mon:false,.tue:false,.wed:false,.thu:false,.fri:false,.sat:false,.sun:false]
//    var repetitionTimeOfDate:[DateEnum:Date] = [.mon:Date(), .tue:Date(), .wed:Date(), .thu:Date(), .fri:Date(), .sat:Date(), .sun:Date()]
//    
//    func anyRepetitionDate() -> Bool {
//        return repetitionDateFlags.values.contains(true)
//    }
//    
//    func clone() -> RepetitionDate{
//        var newRepetitionDate = RepetitionDate()
//        newRepetitionDate.repetitionDateFlags = self.repetitionDateFlags
//        newRepetitionDate.repetitionTimeOfDate = self.repetitionTimeOfDate
//        
//        return newRepetitionDate
//    }
//    
//    func toString() -> String {
//        var repetitionDate = String()
//        
//        repetitionDate += repetitionDateFlags[.mon]! == true ? "월 " : ""
//        repetitionDate += repetitionDateFlags[.tue]! == true ? "화 " : ""
//        repetitionDate += repetitionDateFlags[.wed]! == true ? "수 " : ""
//        repetitionDate += repetitionDateFlags[.thu]! == true ? "목 " : ""
//        repetitionDate += repetitionDateFlags[.fri]! == true ? "금 " : ""
//        repetitionDate += repetitionDateFlags[.sat]! == true ? "토 " : ""
//        repetitionDate += repetitionDateFlags[.sun]! == true ? "일" : ""
//        
//        if (repetitionDate == "") {
//            repetitionDate = "안 함"
//        }
//        
//        return repetitionDate
//    }
//    
//    func repetitionTimeOf(date:DateEnum) -> Date? {
//        return repetitionTimeOfDate[date]
//    }
//    
//}

enum RouteCategoryEnum{
    case routine, favorites
    
    func toInt() -> Int{
        switch self {
        case .routine:
            return 0
        default:
            return 1
        }
    }
}

var routineCategory = RouteCategory(title: "일상", routeInfoList: [RouteInfo]())
var favoritesCategory = RouteCategory(title: "즐겨찾기", routeInfoList: [RouteInfo]())
var routeCategoryList = [routineCategory, favoritesCategory]


