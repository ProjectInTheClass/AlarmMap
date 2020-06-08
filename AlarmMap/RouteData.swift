//
//  Route.swift
//  TableViewPractice
//
//  Created by 김요환 on 2020/04/23.
//  Copyright © 2020 Kloong. All rights reserved.

import Foundation

// by CSEDTD
infix operator ==
func ==(lhs: Location, rhs: Location) -> Bool {
    if (lhs.title == rhs.title) && (lhs.nickname == rhs.nickname) && (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude) {
        return true
    } else {
        return false
    }
}

// by CSEDTD
enum MoveBy {
    case bus, metro, walk
}

struct RouteCategory{
    var title: String
    var routeInfoList: [RouteInfo]
}

class RouteInfo{
    var title : String
    var subtitle: String
    
    var route: Route // 얘는 string이 아니라 실제 경로에 대한 정보를 담고 있어야 한다.
    var routeAlarmList = [RouteAlarm]()
    var routeAlarmIsOn = true
    
    // by CSEDTD - 추가 기능으로 빼 두자
    var scheduledDate: Date
    
    //임시 init
    init(){
        self.title = "이름"
        self.subtitle = "설명"
        self.route = Route()
        self.scheduledDate = Date()
    }
    
    // by CSEDTD
    init(title: String, subtitle: String?, route: Route, scheduledDate: Date) {
        self.title = title
        self.subtitle = subtitle ?? ""
        self.route = route
        self.scheduledDate = scheduledDate
    }
    
    // by CSEDTD
    func removeAlarm(at index: Int) {
        routeAlarmList[index].startTimer.invalidate()
        
        if workingAlarm == routeAlarmList[index] {
            routeAlarmList[index].detach()
        }
        
        routeAlarmList.remove(at: index)
    }
}

class Route{
    // by CSEDTD
    var startingPoint: Location
    var destinationPoint: Location
    var bmw: MoveBy
    //var somethingNeed: String
    //실제 경로(버스, 지하철, 도보 등)
    var nextRoute: Route?
    
    //임시 init
    init() {
        // by CSEDTD
        self.startingPoint = Location(title: "길음뉴타운동부센트레빌아파트", nickname: "집", latitude: 37.610374, longitude: 127.024414)
        self.destinationPoint = Location(title: "GS25 길음동부점", nickname: "편의점", latitude: 37.608914, longitude: 127.023302)
        self.bmw = .walk
        //self.somethingNeed = ""
        self.nextRoute = nil
    }
    
    // by CSEDTD
    init(from start: Location, to dest: Location, moveBy: MoveBy, next: Route) {
        self.startingPoint = start
        self.destinationPoint = dest
        self.bmw = moveBy
        //self.somethingNeed = additionalInfo
        self.nextRoute = next
    }
    
    init(_ otherRoute: Route) {
        self.startingPoint = otherRoute.startingPoint
        self.destinationPoint = otherRoute.destinationPoint
        self.bmw = otherRoute.bmw
        
        if otherRoute.nextRoute != nil {
            self.nextRoute = Route(otherRoute.nextRoute!)
        }
        else {
            self.nextRoute = nil
        }
    }
}

// by CSEDTD
struct Location {
    var title: String // ex 지하철역, 정류장, ...
    var nickname: String // ex 학교, 회사, 집, ...
    var latitude: Double
    var longitude: Double
    
    init() {
        self.title = ""
        self.nickname = ""
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(title: String, nickname: String, latitude: Double, longitude: Double) {
        self.title = title
        self.nickname = nickname
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // TODO
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

