//
//  Bus.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/05/06.
//  Copyright © 2020 Kloong. All rights reserved.
//

import Foundation

class BusStop: Node, Codable{
    var name: String?
    var arsId: String?
    var direction: String?
    var busList: [Bus]?
    var selectedBusList = [Bus]()
    
    init(name:String?, arsId: String?, direction:String?, busList:[Bus]?, selectedBusList: [Bus]){
        self.name = name
        self.arsId = arsId
        self.direction = direction
        self.busList = busList
        self.selectedBusList = selectedBusList
    }
}

class Bus : Codable {
    var busNumber: String
    var firstBusRemainingTime: String
    var firstBusCurrentLocation:String?
    var secondBusRemainingTime: String
    var secondBusCurrentLocation:String?
    
    //var type:String //enum으로 하나 만들어야할듯.
    
    init(busNumber:String, firstBusRemainingTime:String,firstBusCurrentLocation:String?,secondBusRemainingTime:String,secondBusCurrentLocation:String?){
        self.busNumber = busNumber
        self.firstBusRemainingTime = firstBusRemainingTime
        self.firstBusCurrentLocation = firstBusCurrentLocation
        self.secondBusRemainingTime = secondBusRemainingTime
        self.secondBusCurrentLocation = secondBusCurrentLocation
    }
    
    init(busNumber:String){
        self.busNumber = busNumber
        self.firstBusRemainingTime = ""
        self.firstBusCurrentLocation = ""
        self.secondBusRemainingTime = ""
        self.secondBusCurrentLocation = ""
    }
    
    func decreaseRemainingTime(){
        if(self.firstBusRemainingTime.hasPrefix("[")){
            let range=firstBusRemainingTime.index(firstBusRemainingTime.startIndex, offsetBy: 5)...firstBusRemainingTime.index(firstBusRemainingTime.endIndex, offsetBy: -1)
            firstBusRemainingTime=String(firstBusRemainingTime[range])
        }
        if(self.secondBusRemainingTime.hasPrefix("[")){
            let range=secondBusRemainingTime.index(secondBusRemainingTime.startIndex, offsetBy: 5)...secondBusRemainingTime.index(secondBusRemainingTime.endIndex, offsetBy: -1)
            secondBusRemainingTime=String(secondBusRemainingTime[range])
        }
        if(self.firstBusRemainingTime.contains("분")){
            var retString:String=""
            var minute:String=""
            var station:String=""
            var minuteflag:Bool = false
            var stationflag:Bool = false
            
            for c in firstBusRemainingTime{
                if(c == "분"){
                    minuteflag=true
                }
                else if(!minuteflag){
                    minute+=String(c)
                }
                
                if(c == "["){
                    stationflag = true
                }
                if(stationflag){
                    station+=String(c)
                }
            }
            
            let intMinute = Int(minute)
            if(firstBusRemainingTime.contains("초")){
                var second:String=""
                var secondflag:Bool=false
                for c in firstBusRemainingTime{
                    if(c == "초"){
                        break
                    }
                    else if(secondflag){
                        second+=String(c)
                    }
                    if(c == " "){
                        secondflag=true
                    }
                }
                
                let intSecond = Int(second)
                if(intSecond==1){
                    retString += (minute+"분 후 "+station)
                }
                else{
                    retString += (minute+"분 "+String(intSecond! - 1)+"초 후 "+station)
                }
            }
            else if(intMinute == 1){
                retString = "곧 도착"
            }
            else{
                retString+=(String(intMinute! - 1)+"분 "+"59초 후 "+station)
            }
            firstBusRemainingTime = retString
        }
        
        if(self.secondBusRemainingTime.contains("분")){
            var retString:String=""
            var minute:String=""
            var station:String=""
            var minuteflag:Bool = false
            var stationflag:Bool = false
            for c in secondBusRemainingTime{
                if(c == "분"){
                    minuteflag=true
                }
                else if(!minuteflag){
                    minute+=String(c)
                }
                
                if(c == "["){
                    stationflag = true
                }
                if(stationflag){
                    station+=String(c)
                }
            }
            let intMinute = Int(minute)
            if(secondBusRemainingTime.contains("초")){
                var second:String=""
                var secondflag:Bool=false
                for c in secondBusRemainingTime{
                    if(c == "초"){
                        break
                    }
                    else if(secondflag){
                        second+=String(c)
                    }
                    if(c == " "){
                        secondflag=true
                    }
                }
                let intSecond = Int(second)
                if(intSecond==1){
                    retString += (minute+"분 후 "+station)
                }
                else{
                    retString += (minute+"분 "+String(intSecond! - 1)+"초 후 "+station)
                }
            }
            else if(intMinute == 1){
                retString = "곧 도착"
            }
            else{
                retString+=(String(intMinute! - 1)+"분 "+"59초 후 "+station)
            }
            secondBusRemainingTime = retString
        }
    }

}

func insertSpace(str:String) -> String {
    var space:String = ""
    for c in str{
        space+=String(c)
        if(c == "분" || c == "초" || c == "후"){
            space+=" "
        }
    }
    
    print(space)
    return space
}

var busStopList:[BusStop] = []
var searchedBusStopList:[BusStop] = []
