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
    
    var scheduledDate: Date

    //임시 init
    init(){
        self.title = ""
        self.subtitle = ""
        self.route = Route()
        self.routeAlarmList = [RouteAlarm]()
        self.scheduledDate = Date()
    }
}

class Route{
    //startingPoint와 destinationPoint는 String이 아니라 Location 정보를 담고 있어야 함.
    var startingPoint: String
    var destinationPoint: String

    var somethingNeed: String
    //실제 경로(버스, 지하철, 출발지, 도착지 등)
    
    //임시 init
    init() {
        self.startingPoint = ""
        self.destinationPoint = ""
        self.somethingNeed = ""
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


