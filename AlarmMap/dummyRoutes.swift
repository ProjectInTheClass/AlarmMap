//
//  dummyRoutes.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import Foundation

var w1 = WayPoint(location: Location(name: "길음뉴타운동부센트레빌아파트", latitude: 37.610374, longitude: 127.024414), type: .walk, distance: 237, takenSeconds: 240, onboarding: true, node: Node(), radius: 300)

var w2BusStop = BusStop(name: "미아초교", arsId: "08171", direction: "길음동동부아파트", busList: [Bus(busNumber: "104"), Bus(busNumber: "109"), Bus(busNumber: "121"),Bus(busNumber: "152"),Bus(busNumber: "1115")], selectedBusList: [Bus(busNumber: "104",firstBusRemainingTime: "곧 도착",firstBusCurrentLocation: "",secondBusRemainingTime: "",secondBusCurrentLocation: ""), Bus(busNumber: "109",firstBusRemainingTime: "곧 도착",firstBusCurrentLocation: "",secondBusRemainingTime: "",secondBusCurrentLocation: ""),Bus(busNumber: "152",firstBusRemainingTime: "곧 도착",firstBusCurrentLocation: "",secondBusRemainingTime: "",secondBusCurrentLocation: "")])

var w2 = WayPoint(location: Location(name: "미아초교", latitude: 37.611534, longitude: 127.022032), type: .bus, distance: 945, takenSeconds: 420, onboarding: true, node: w2BusStop, radius: 100)

var w3BusStop = BusStop(name: "길음뉴타운", arsId: "08003", direction: "미아리고개,미아리예술극장", busList: [Bus](), selectedBusList: [Bus]())

var w3 = WayPoint(location: Location(name: "길음뉴타운", latitude: 37.603669, longitude: 127.024253), type: .bus, distance: 80, takenSeconds: 60, onboarding: false, node: w3BusStop, radius: 100)

var w4MetroStation = MetroStation(name: "길음", line: "4호선", direction: "하행", trainList: [Train(timeRemaining: "1분 전", currentStation: "미아사거리", terminalStation: "오이도"),Train(timeRemaining: "3분 전", currentStation: "미아", terminalStation: "오이도")])

var w4 = WayPoint(location: Location(name: "길음", latitude: 37.603188, longitude: 127.024927), type: .metro, distance: 5500, takenSeconds: 900, onboarding: true, node: w4MetroStation, radius: 250)

var w5MetroStation = MetroStation(name: "동대문역사문화공원", line: "4호선", direction: "하행", trainList: [Train]())

var w5 = WayPoint(location: Location(name: "동대문역사문화공원", latitude: 37.565111, longitude: 127.007776), type: .metro, distance: 0, takenSeconds: 0, onboarding: false, node: w5MetroStation, radius: 300)

var w6MetroStation = MetroStation(name: "동대문역사문화공원", line: "2호선", direction: "내선", trainList: [Train(timeRemaining: "곧 도착", currentStation: "동대문역사문화공원", terminalStation: "성수"),Train(timeRemaining: "3분 전", currentStation: "을지로3가", terminalStation: "성수")])

var w6 = WayPoint(location: Location(name: "동대문역사문화공원", latitude: 37.565111, longitude: 127.007776), type: .metro, distance: 3600, takenSeconds: 720, onboarding: true, node: w6MetroStation, radius: 300)

var w7MetroStation = MetroStation(name: "한양대", line: "2호선", direction: "내선", trainList: [Train]())

var w7 = WayPoint(location: Location(name: "한양대", latitude: 37.555621, longitude: 127.043666), type: .metro, distance: 220, takenSeconds: 180, onboarding: false, node: w7MetroStation, radius: 300)

var w8 = WayPoint(location: Location(name: "한양대학교", latitude: 37.557258, longitude: 127.045086), type: .end, distance: 0, takenSeconds: 0, onboarding: false, node: Node(), radius: 300)

var dummyRouteInfo1 = RouteInfo(title: "등교", subtitle: "한양대학교", startingPoint: w1, destinationPoint: w8, route: [w1,w2,w3,w4,w5,w6,w7,w8], scheduledDate: Date(), displacement: 10582, time: 44, walk: 537, cost: 1250, transferCount: 2)

//-------------------------------------------------------------------------------

var w9 = WayPoint(location: Location(name: "한양대학교", latitude: 37.557258, longitude: 127.045086), type: .walk, distance: 220, takenSeconds: 180, onboarding: false, node: Node(), radius: 300)

var w10MetroStation = MetroStation(name: "한양대", line: "2호선", direction: "외선", trainList: [Train(timeRemaining: "곧 도착", currentStation: "한양대", terminalStation: "어디어디"),Train(timeRemaining: "3분 후", currentStation: "성수", terminalStation: "어딘가")])

var w10 = WayPoint(location: Location(name: "한양대", latitude: 37.555621, longitude: 127.043666), type: .metro, distance: 3600, takenSeconds: 660, onboarding: true, node: w10MetroStation, radius: 300)

var w11MetroStation = MetroStation(name: "동대문역사문화공원", line: "2호선", direction: "외선", trainList: [Train]())

var w11 = WayPoint(location: Location(name: "동대문역사문화공원", latitude: 37.565111, longitude: 127.007776), type: .metro, distance: 0, takenSeconds: 0, onboarding: false, node: w11MetroStation, radius: 500)

var w12MetroStation = MetroStation(name: "동대문역사문화공원", line: "4호선", direction: "상행", trainList: [Train(timeRemaining: "2분 전", currentStation: "충무로", terminalStation: "당고개"),Train(timeRemaining: "4분 전", currentStation: "명동", terminalStation: "당고개")])

var w12 = WayPoint(location: Location(name: "동대문역사문화공원", latitude: 37.565111, longitude: 127.007776), type: .metro, distance: 5500, takenSeconds: 960, onboarding: true, node: w12MetroStation, radius: 500)

var w13MetroStation = MetroStation(name: "길음", line: "4호선", direction: "상행", trainList: [Train]())

var w13 = WayPoint(location: Location(name: "길음", latitude: 37.603188, longitude: 127.024927), type: .metro, distance: 151, takenSeconds: 120, onboarding: false, node: w13MetroStation, radius: 500)

var w14BusStop = BusStop(name: "돈암동삼성아파트입구", arsId: "08123", direction: "길음동동부아파트", busList: [Bus(busNumber: "104"), Bus(busNumber: "109"), Bus(busNumber: "153"),Bus(busNumber: "152")], selectedBusList: [Bus(busNumber: "104"), Bus(busNumber: "109"),Bus(busNumber: "152")])

var w14 = WayPoint(location: Location(name: "돈암동삼성아파트입구", latitude: 37.60186, longitude: 127.024537), type: .bus, distance: 1119, takenSeconds: 480, onboarding: true, node: w14BusStop, radius: 300)

var w15BusStop = BusStop(name: "미아초교", arsId: "08172", direction: "송천초등학교,미아뉴타운", busList: [Bus](), selectedBusList: [Bus]())

var w15 = WayPoint(location: Location(name: "미아초교", latitude: 37.610907, longitude: 127.02247), type: .bus, distance: 171, takenSeconds: 180, onboarding: false, node: w15BusStop, radius: 300)

var w16 = WayPoint(location: Location(name: "길음뉴타운동부센트레빌아파트", latitude: 37.610374, longitude: 127.024414), type: .end, distance: 0, takenSeconds: 0, onboarding: false, node: Node(), radius: 300)

var dummyRouteInfo2 = RouteInfo(title: "dummyRouteInfo2", subtitle: "dummy", startingPoint: w9, destinationPoint: w16, route: [w9,w10,w11,w12,w13,w14,w15,w16], scheduledDate: Date(), displacement: 10761, time: 45, walk: 542, cost: 1250, transferCount: 2)

//-------------------------------------------------------------------------------

var w17 = WayPoint(location: Location(name: "서울중앙시장", latitude: 51.50998, longitude: -0.1337), type: .walk, distance: 220, takenSeconds: 180, onboarding: false, node: Node(), radius: 300)

var w18MetroStation = MetroStation(name: "신당", line: "6호선", direction: "하행", trainList: [Train(timeRemaining: "3분 후", currentStation: "약수", terminalStation: "봉화산"),Train(timeRemaining: "11분 후", currentStation: "녹사평", terminalStation: "신내")])

var w18 = WayPoint(location: Location(name: "신당", latitude: -26.2041028, longitude: 28.0473051), type: .metro, distance: 3600, takenSeconds: 660, onboarding: true, node: w18MetroStation, radius: 300)

var w19MetroStation = MetroStation(name: "봉화산", line: "6호선", direction: "하행", trainList: [Train]())

var w19 = WayPoint(location: Location(name: "봉화산", latitude: 55.755786, longitude: 37.617633), type: .metro, distance: 200, takenSeconds: 0, onboarding: false, node: w19MetroStation, radius: 500)

var w20 = WayPoint(location: Location(name: "신내6단지아파트", latitude: 19.0176147, longitude: 72.8561644), type: .end, distance: 1, takenSeconds: 960, onboarding: false, node: w12MetroStation, radius: 500)

var dummyRouteInfo3 = RouteInfo(title: "dummyRouteInfo3", subtitle: "dummy", startingPoint: w17, destinationPoint: w20, route: [w17,w18,w19,w20], scheduledDate: Date(), displacement: 4021, time: 26, walk: 542, cost: 1250, transferCount: 0)

