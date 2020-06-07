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


