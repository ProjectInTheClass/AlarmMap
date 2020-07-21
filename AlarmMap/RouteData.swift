//
//  Route.swift
//  TableViewPractice
//
//  Created by 김요환 on 2020/04/23.
//  Copyright © 2020 Kloong. All rights reserved.

import Foundation

// by CSEDTD
enum MoveBy{
    case bus, metro, walk, end
    
    func toString() -> String{
        switch self {
        case .bus:
            return "bus"
        case .metro:
            return "metro"
        case .walk:
            return "walk"
        case .end:
            return "end"
        }
    }
    
}

struct RouteCategory{
    var title: String
    var routeInfoList: [RouteInfo]
}

// TODO - passStopList in ODSAY
class RouteInfo{
    var title : String
    var subtitle: String?
    
    // TODO
    var route = [WayPoint]()
    var startingPoint = WayPoint(placeholder: 0)
    var destinationPoint = WayPoint(placeholder: 1)
    
    var routeAlarmList = [RouteAlarm]()
    // TODO - switch converted
    var routeAlarmIsOn = false
    
    // TODO - new fields
    // 0623 - route가 만들어질 때
    var totalDisplacement: Double // sum of WayPoint.takenSeconds OR trafficDistance + totalWalk in ODSAY OR totalDistance in ODSAY
    var totalTime: Int // totalTime in ODSAY
    var totalWalk: Int //도보 이동 시간이 아니라 도보 이동 거리
    var totalCost: Int // payment in ODSAY
    var transferCount: Int // subwayBusCount - 1 in ODSAY
    
    // by CSEDTD - 추가 기능으로 빼 두자
    var scheduledDate: Date
    
    //make empty RouteInfo
    init(){
        self.title = ""
        self.subtitle = ""
        self.scheduledDate = Date()
        self.totalDisplacement = -1.0
        self.totalTime = -1
        self.totalWalk = -1
        self.totalCost = -1
        self.transferCount = -1
    }
    
    // by CSEDTD
    init(title: String, subtitle: String?, startingPoint:WayPoint, destinationPoint:WayPoint, route: [WayPoint], scheduledDate: Date, displacement: Double, time: Int, walk: Int, cost: Int, transferCount: Int) {
        self.title = title
        self.subtitle = subtitle ?? ""
        self.startingPoint = startingPoint
        self.destinationPoint = destinationPoint
        self.route = route
        self.scheduledDate = scheduledDate
        self.totalDisplacement = displacement
        self.totalTime = time
        self.totalWalk = walk
        self.totalCost = cost
        self.transferCount = transferCount
    }
    
    // by CSEDTD
    func removeAlarm(at index: Int) {
        routeAlarmList[index].startTimer.invalidate()
        
        if workingAlarm == routeAlarmList[index] {
            routeAlarmList[index].detach()
        }
        
        routeAlarmList.remove(at: index)
    }
    
    struct CodableRouteInfoStruct : Codable{
        var title : String
        var subtitle: String?
        
        var route: [WayPoint.CodableWayPointStruct]
        var startingPoint: WayPoint.CodableWayPointStruct
        var destinationPoint: WayPoint.CodableWayPointStruct
        
        var routeAlarmList: [RouteAlarm.CodableRouteAlarmStruct]
        var routeAlarmIsOn: Bool
        var totalDisplacement: Double
        var totalTime: Int
        var totalWalk: Int
        var totalCost: Int
        var transferCount: Int
        
        var scheduledDate: Date
        
        func toRouteInfoClassInstance() -> RouteInfo{
            let instance = RouteInfo(title: self.title, subtitle: self.subtitle, startingPoint: self.startingPoint.toWayPointClassInstance(), destinationPoint: self.destinationPoint.toWayPointClassInstance(), route: [], scheduledDate: self.scheduledDate, displacement: self.totalDisplacement, time: self.totalTime, walk: self.totalWalk, cost: self.totalCost, transferCount: self.transferCount)
            
            instance.routeAlarmIsOn = self.routeAlarmIsOn
            
            instance.route = self.route.map({(codableWayPointStruct) -> WayPoint in
                return codableWayPointStruct.toWayPointClassInstance()
            })
            
            instance.routeAlarmList = self.routeAlarmList.map({(codableRouteAlarmStruct) -> RouteAlarm in
                return codableRouteAlarmStruct.toRouteAlarmClassInstance()
            })
            
            return instance
        }
    }
    
    func toCodableStruct() ->CodableRouteInfoStruct{
        var codableStruct = CodableRouteInfoStruct(title: self.title, subtitle: self.subtitle, route: [], startingPoint: self.startingPoint.toCodableStruct(), destinationPoint: self.destinationPoint.toCodableStruct(), routeAlarmList: [], routeAlarmIsOn: self.routeAlarmIsOn, totalDisplacement: self.totalDisplacement, totalTime: self.totalTime, totalWalk: self.totalWalk, totalCost: self.totalCost, transferCount: self.transferCount, scheduledDate: self.scheduledDate)
        
        codableStruct.route = self.route.map({(waypoint) -> WayPoint.CodableWayPointStruct in
            return waypoint.toCodableStruct()
        })
        
        codableStruct.routeAlarmList = self.routeAlarmList.map({(routeAlarm) -> RouteAlarm.CodableRouteAlarmStruct in
            return routeAlarm.toCodableStruct()
        })
        
        return codableStruct
    }

}

// Don't misunderstand, this is empty class
class Node {
    // lane(지하철 노선명, 버스 번호, 버스 타입, 버스 코드, 지하철 노선 번호, 지하철 도시코드) in ODSAY
}

// TODO - new fields
// 0623 - route가 만들어질 때
class WayPoint{
    // TODO - 0611
//    var name: String // not optional. (~에서 하차, ~에서 승차) // startName, endName in ODSAY // startID, endID in ODSAY // startExitNo, endExitNo in ODSAY
    var location: Location // startX, startY, endX, endY, startExitX, startExitY, endExitX, endExitY in ODSAY
    var type: MoveBy // subPath in ODSAY
    var distance: Double // distance in ODSAY
    var takenSeconds: Int // 다음 WayPoint까지 걸리는 시간 // sectionTime in ODSAY
    var onboarding: Bool // true - 승차, false - 하차
    var node: Node? // either BusStop or MetroStation

    // firstStartStation, lastEndStation in ODSAY
    var radius: Double? // 도착
    
    init() {
        self.radius = 300
        
//        self.name = "이름"
        self.location = Location()
        self.type = .walk
        self.distance = -1
        self.takenSeconds = -1
        self.onboarding = false
        self.node = nil
    }
    
    init(/*name: String, */location: Location, type: MoveBy, distance:Double, takenSeconds: Int, onboarding: Bool, node: Node, radius: Double?) {
//        self.name = name
        self.location = location
        self.type = type
        self.distance = distance
        self.takenSeconds = takenSeconds
        self.onboarding = onboarding
        self.node = node
        
        self.radius = radius
       
    }
    
    init(placeholder: Int) { //0:시작점, 1:도착점
        self.location = Location(placeholder: placeholder)
        self.type = placeholder == 0 ? .walk : .end
        self.distance = placeholder == 0 ? -1 : 0
        self.takenSeconds = placeholder == 0 ? -1 : 0
        self.onboarding = false
        self.node = Node() //empty node
        self.radius = 300
    }
    
    func isAvailable() -> Bool{
        return self.location.isAvailable()
    }
    
    func toString() -> String {
        let name = self.location.name
        if self.type == .bus {
            return name + " 정류장"
        } else if self.type == .metro {
            return name + " 역 (" + (self.node as! MetroStation).line + ")"
        } else {
            return name
        }
    }
    
//    enum CodingKeys : CodingKey{
//        case location, type, distance, takenSeconds, onboarding, busStopNode, metroStationNode, radius
//    }
//
    struct CodableWayPointStruct : Codable{
        var location: Location
        var type: String
        var distance: Double
        var takenSeconds: Int
        var onboarding: Bool
        var busStopNode: BusStop?
        var metroStationNode: MetroStation?
        var radius: Double?
        
        func toWayPointClassInstance() -> WayPoint{
            let instance = WayPoint(location: self.location, type: .walk, distance: self.distance, takenSeconds: self.takenSeconds, onboarding: self.onboarding, node: Node(), radius: self.radius)
            
            switch self.type {
            case "bus":
                instance.type = .bus
                instance.node = self.busStopNode
            case "metro":
                instance.type = .metro
                instance.node = self.metroStationNode
            case "walk":
                instance.type = .walk
            default:
                instance.type = .end
            }
            
            return instance
        }
    }
    
    func toCodableStruct() -> CodableWayPointStruct{
        var codableStruct = CodableWayPointStruct(location: self.location, type: self.type.toString(), distance:self.distance, takenSeconds: self.takenSeconds, onboarding: self.onboarding, busStopNode: nil, metroStationNode: nil, radius: self.radius)
        
        switch type {
        case .walk, .end:
            return codableStruct
        case .bus:
            codableStruct.busStopNode = self.node as? BusStop
            return codableStruct
        case .metro:
            codableStruct.metroStationNode = self.node as? MetroStation
            return codableStruct
        }
    }
    
}

// by CSEDTD
// TODO - 0611
class Location :Codable{
    var name: String
    var latitude: Double
    var longitude: Double
    
    init() {
        self.name = ""
        self.latitude = 65536.0
        self.longitude = 65536.0
    }
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(placeholder: Int) {
        if (placeholder == 0) {
            self.name = ""
        } else if (placeholder == 1) {
            self.name = ""
        } else {
            self.name = ""
        }
        self.latitude = 65536.0
        self.longitude = 65536.0
    }
    
    func isAvailable() -> Bool{
        return self.latitude >= -90.0 && self.latitude <= 90.0 && self.longitude >= -180.0 && self.longitude <= 180.0
    }
}

/*
class Route{
    // by CSEDTD
    // 처음 만들 때 start, dest 아예 만들어라
    var startingPoint: Location
    var destinationPoint: Location
    var bmw: MoveBy
    //var somethingNeed: String
    //실제 경로(버스, 지하철, 도보 등)

    //임시 init
    init() {
        // by CSEDTD
        
        self.startingPoint = Location(title: "길음뉴타운동부센트레빌아파트", nickname: "집", latitude: 37.610374, longitude: 127.024414)
        self.destinationPoint = Location(title: "GS25 길음동부점", nickname: "편의점", latitude: 37.608914, longitude: 127.023302)
        self.bmw = .walk
        //self.somethingNeed = ""
    }
    
    // 실험 in 한양대 init
    init(ex: Int) {
        // by CSEDTD
        if (ex == 1) {
            self.startingPoint = Location(title: "카페흥신소", nickname: "실험장소1", latitude: 37.557359, longitude: 127.041637)
            self.destinationPoint = Location(title: "한양대 당구클럽", nickname: "실험장소2", latitude: 37.557009, longitude: 127.042465)
            self.bmw = .walk
            //self.somethingNeed = ""
        } else if (ex == 2) {
            self.startingPoint = Location(title: "한양대 당구클럽", nickname: "실험장소2", latitude: 37.557009, longitude: 127.042465)
            self.destinationPoint = Location(title: "한양대역 4번출구", nickname: "실험장소3", latitude: 37.55606385, longitude: 127.043266)
            self.bmw = .walk
            //self.somethingNeed = ""
        } else {
            self.startingPoint = Location(title: "길음뉴타운동부센트레빌아파트", nickname: "집", latitude: 37.610374, longitude: 127.024414)
            self.destinationPoint = Location(title: "GS25 길음동부점", nickname: "편의점", latitude: 37.608914, longitude: 127.023302)
            self.bmw = .walk
            //self.somethingNeed = ""
        }
    }
    
    // by CSEDTD
    init(from start: Location, to dest: Location, moveBy: MoveBy, next: Route) {
        self.startingPoint = start
        self.destinationPoint = dest
        self.bmw = moveBy
        //self.somethingNeed = additionalInfo
    }
    
    init(_ otherRoute: Route) {
        self.startingPoint = otherRoute.startingPoint
        self.destinationPoint = otherRoute.destinationPoint
        self.bmw = otherRoute.bmw
    }
}
 */

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

// 0611
var kloongHouse = WayPoint(location: Location(name: "길음뉴타운동부센트레빌아파트", latitude: 37.610374, longitude: 127.024414), type: .walk, distance: 100, takenSeconds: 120, onboarding: true, node: Node(), radius: nil)
var kloongGS25 = WayPoint(location: Location(name: "GS25 길음동부점", latitude: 37.608914, longitude: 127.023302), type: .end, distance: 0, takenSeconds: 0, onboarding: false, node: Node(), radius: 5.0/*TODO*/)
var busStop1 = WayPoint(location: Location(name: "길음동동부센트레빌", latitude: 37.610374, longitude: 127.024414), type: .bus, distance: 1000, takenSeconds: 5, onboarding: true, node: BusStop(name: "길음동동부센트레빌", arsId: "08173", direction: "몰라", busList: [Bus(busNumber: "121", firstBusRemainingTime: "", firstBusCurrentLocation: "", secondBusRemainingTime: "", secondBusCurrentLocation: "")], selectedBusList: [Bus(busNumber: "121", firstBusRemainingTime: "", firstBusCurrentLocation: "", secondBusRemainingTime: "", secondBusCurrentLocation: "")]), radius: 10)
var busStop2 = WayPoint(location: Location(name: "길음역", latitude: 37.610374, longitude: 127.024414), type: .walk, distance: 100, takenSeconds: 2, onboarding: false, node: Node(), radius: 10)

var waypointSearchList: [WayPoint] = [kloongHouse, kloongGS25]

var tempRouteInfo1 = RouteInfo(title: "dummyTitle1", subtitle: "dummySubtitle1", startingPoint: kloongHouse, destinationPoint: kloongGS25, route: [kloongHouse,busStop1,busStop2, kloongGS25], scheduledDate: Date(), displacement: 1500, time: 15, walk: 100, cost: 1250, transferCount: 0)
var tempRouteInfo2 = RouteInfo(title: "dummyTitle2", subtitle: "dummySubtitle2", startingPoint: kloongGS25, destinationPoint: kloongHouse, route: [kloongGS25,kloongHouse], scheduledDate: Date(), displacement: 100, time: 10, walk:10,  cost: 0, transferCount: 0)

var routeSearchList:[RouteInfo] = [] //[dummyRouteInfo1,dummyRouteInfo2]
var userSelectedStartingPoint = WayPoint(placeholder: 0)
var userSelectedDestinationPoint = WayPoint(placeholder: 1)

// 0623 TODO - item of routeSearchList
struct RouteSearchResult {
    // TODO - new fields
    // 0623 - route가 만들어질 때
    var totalDisplacement: Double // sum of WayPoint.takenSeconds OR trafficDistance + totalWalk in ODSAY OR totalDistance in ODSAY
    var totalTime: Int // totalTime in ODSAY
    var totalWalk: Int //도보 이동 시간이 아니라 도보 이동 거리
    var totalCost: Int // payment in ODSAY
    var transferCount: Int // subwayBusCount - 1 in ODSAY
    var route: [WayPoint]
}
