//
//  Bus.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/05/06.
//  Copyright © 2020 Kloong. All rights reserved.
//

import Foundation

struct BusStop {
    let name: String
    let direction: String
    var busList: [Bus]
}

struct Bus {
    var busNumber: String
    var firstBusRemainingTime: String
    var firstBusCurrentLocation:String
    var secondBusRemainingTime: String
    var secondBusCurrentLocation:String

}

var bus121 = Bus(busNumber: "121", firstBusRemainingTime: "곧 도착",firstBusCurrentLocation: "1번째 전(여유)", secondBusRemainingTime: "차고지 대기",secondBusCurrentLocation: "")

var busStop1 = BusStop(name: "길음역", direction: "길음동동부아파트 방면", busList: [bus121])

var bus104 = Bus(busNumber: "104", firstBusRemainingTime: "2분 34초",firstBusCurrentLocation: "1번째 전(여유)", secondBusRemainingTime: "7분 52초",secondBusCurrentLocation: "4번째 전(여유)")

var bus109 = Bus(busNumber: "109", firstBusRemainingTime: "12분 15초",firstBusCurrentLocation: "7번째 전(여유)", secondBusRemainingTime: "14분 32초",secondBusCurrentLocation: "8번째 전(여유)")

var busStop2 = BusStop(name: "미아초교", direction: "송천초등학교,미아뉴타운 방면", busList: [bus104,bus109])

var busStopList = [busStop1,busStop2]
