//
//  Bus.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/05/06.
//  Copyright © 2020 Kloong. All rights reserved.
//

import Foundation

class BusStop {
    var name: String?
    var direction: String?
    var busList: [Bus]?
    
    init(name:String?, direction:String?, busList:[Bus]?){
        self.name = name
        self.direction = direction
        self.busList = busList
    }
}

class Bus {
    var busNumber: String
    var firstBusRemainingTime: String
    var firstBusCurrentLocation:String?
    var secondBusRemainingTime: String
    var secondBusCurrentLocation:String?
    
    init(busNumber:String, firstBusRemainingTime:String,firstBusCurrentLocation:String?,secondBusRemainingTime:String,secondBusCurrentLocation:String?){
        self.busNumber = busNumber
        self.firstBusRemainingTime = firstBusRemainingTime
        self.firstBusCurrentLocation = firstBusCurrentLocation
        self.secondBusRemainingTime = secondBusRemainingTime
        self.secondBusCurrentLocation = secondBusCurrentLocation
    }
    
    /*func firstBusRemainingTimeToString() ->String{
        if(self.firstBusRemainingTime <= -15){
            return "도착 또는 출발"
        }
        else if(self.firstBusRemainingTime <= 0){
            return "곧 도착"
        }
        else if(self.firstBusRemainingTime == -1){
            return "차고지 대기"
        }
        else{
            return "\(firstBusRemainingTime/60)분 \(firstBusRemainingTime%60)초"
        }
    }
    
    func secondBusRemainingTimeToString() ->String{
        if(self.secondBusRemainingTime <= -15){
            return "도착 또는 출발"
        }
        else if(self.secondBusRemainingTime <= 0){
            return "곧 도착"
        }
        else if(self.secondBusRemainingTime == Int.max){
            return "차고지 대기"
        }
        else{
            return "\(secondBusRemainingTime/60)분 \(secondBusRemainingTime%60)초"
        }
    }
    
    func decreaseRemainingTime(){
        if(self.firstBusRemainingTime != -15 && self.firstBusRemainingTime != Int.max){
            self.firstBusRemainingTime -= 1
        }
        if(self.secondBusRemainingTime != -15 && self.secondBusRemainingTime != Int.max){
            self.secondBusRemainingTime -= 1
        }
    }*/

}

/*var bus121 = Bus(busNumber: "121", firstBusRemainingTime: 0 ,firstBusCurrentLocation: "1번째 전(여유)", secondBusRemainingTime: Int.max ,secondBusCurrentLocation: "")

var busStop1 = BusStop(name: "길음역", direction: "길음동동부아파트 방면", busList: [bus121])

var bus104 = Bus(busNumber: "104", firstBusRemainingTime: 154 ,firstBusCurrentLocation: "1번째 전(여유)", secondBusRemainingTime: 472 ,secondBusCurrentLocation: "4번째 전(여유)")

var bus109 = Bus(busNumber: "109", firstBusRemainingTime: 735 ,firstBusCurrentLocation: "7번째 전(여유)", secondBusRemainingTime: 872 ,secondBusCurrentLocation: "8번째 전(여유)")

var busStop2 = BusStop(name: "미아초교", direction: "송천초등학교,미아뉴타운 방면", busList: [bus104,bus109])*/

var busStopList:[BusStop] = []
