//
//  callBusAPI.swift
//  AlarmMap
//
//  Created by SeoungJun Oh on 2020/05/29.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyXMLParser

func getBusURL(url:String, params:[String: Any]) -> URL {
    let urlParams = params.compactMap({ (key, value) -> String in
        return "\(key)=\(value)"
    }).joined(separator: "&")
    let withURL = url + "?\(urlParams)"
    let encoded = withURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&serviceKey=" + busKey
    return URL(string:encoded)!
}

func getBusStationData(stSrch: String, group:DispatchGroup) {
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByName"
    let url = getBusURL(url: SeoulStationURL, params: ["stSrch": stSrch])
    
    group.enter()
    AF.request(url,method: .get).validate()
        .responseString(queue: .global(), encoding: nil, completionHandler: { response in
            print(" - API url: \(String(describing: response.request!))")

            //if case success
            switch response.result {
            case .success(let value):
                let responseString = NSString(data: response.data!, encoding:
                    String.Encoding.utf8.rawValue )
                let xml = try! XML.parse(String(responseString!))
                //self.myLabel.text=xml.text
                //print(responseString)
                //var myBusStopList:[BusStop]=[]
                for element in xml["ServiceResult"]["msgBody"]["itemList"] {
                    /*if let stNm = element["stNm"].text, let stId = element["stId"].text, let arsId =
                     element["arsId"].text {
                     print("stNm = \(stNm), stId = \(stId), arsId = \(arsId)")
                     }*/
                    var myBusStop=BusStop(name: nil, arsId: nil, direction: nil, busList: [], selectedBusList: [])
                    
                    if let arsId =
                        element["arsId"].text, let stNm = element["stNm"].text {
                        print("arsId = \(arsId)")
                        if(arsId == "0"){
                            continue
                        }
                        myBusStop.name = stNm
                        myBusStop.arsId = arsId
                        getBusStation(arsId: arsId, myBusStop : myBusStop, group: group)
                        //myBusStopList.append(myBusStop!)
                    }
                    searchedBusStopList.append(myBusStop)
                }
                group.leave()
            
            case .failure(let error):
                print(error)
                group.leave()
            }
    })
    
    group.leave()
}

func getBusStation(arsId: String, myBusStop:BusStop, group:DispatchGroup) {
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid"
    let url = getBusURL(url: SeoulStationURL, params: ["arsId": arsId])
    
    group.enter()
    AF.request(url,method: .get).validate()
        .responseString(queue: .global(), encoding: nil, completionHandler: { response in
            print(" - API url: \(String(describing: response.request!))")
            
            switch response.result {
            case .success(let value):
                let responseString = NSString(data: response.data!, encoding:
                    String.Encoding.utf8.rawValue )
                let xml = try! XML.parse(String(responseString!))
                //self.myLabel.text=xml.text
                //print(responseString)
                var myBusList:[Bus]=[]
                for element in xml["ServiceResult"]["msgBody"]["itemList"] {
                    if let arrmsg1 = element["arrmsg1"].text, let arrmsg2 = element["arrmsg2"].text, let rtNm =
                        element["rtNm"].text, let adirection = element["adirection"].text, let nxtStn = element["nxtStn"].text {
                        print("stNm = \(arrmsg1), stId = \(arrmsg2), arsId = \(arsId), rtNm = \(rtNm), adirection = \(adirection)")
                        
                        var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: insertSpace(str: arrmsg1), firstBusCurrentLocation: nil, secondBusRemainingTime: insertSpace(str: arrmsg2), secondBusCurrentLocation: nil)
                        //var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                        myBusList.append(myBus)
                        myBusStop.direction = adirection
                    }
                    
                }
                myBusStop.busList=myBusList
                group.leave()

            case .failure(let error):
                print(error)
                group.leave()
            }
    })
}

func getBusList(arsId: String, myBusStop:BusStop, busListSettingTV:UITableView) {
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid"
    let url = getBusURL(url: SeoulStationURL, params: ["arsId": arsId])
    
    //group.enter()
    AF.request(url,method: .get).validate()
        .responseString(queue: .global(), encoding: nil, completionHandler: { response in
            print(" - API url: \(String(describing: response.request!))")
            
            switch response.result {
            case .success(let value):
                let responseString = NSString(data: response.data!, encoding:
                    String.Encoding.utf8.rawValue )
                let xml = try! XML.parse(String(responseString!))
                //self.myLabel.text=xml.text
                //print(responseString)
                var myBusList:[Bus]=[]
                for element in xml["ServiceResult"]["msgBody"]["itemList"] {
                    if let arrmsg1 = element["arrmsg1"].text, let arrmsg2 = element["arrmsg2"].text, let rtNm =
                        element["rtNm"].text, let adirection = element["adirection"].text, let nxtStn = element["nxtStn"].text {
                        print("stNm = \(arrmsg1), stId = \(arrmsg2), arsId = \(arsId), rtNm = \(rtNm), adirection = \(adirection)")
                        
                        var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: insertSpace(str: arrmsg1), firstBusCurrentLocation: nil, secondBusRemainingTime: insertSpace(str: arrmsg2), secondBusCurrentLocation: nil)
                        //var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                        myBusList.append(myBus)
                        myBusStop.direction = adirection
                    }
                    
                }
                myBusStop.busList=myBusList
                DispatchQueue.main.async {
                    busListSettingTV.reloadData()
                }
               // group.leave()

            case .failure(let error):
                print(error)
                //group.leave()
            }
    })
}

func refreshBusStation(arsId: String, myBusStop:BusStop, busFavoritesTV:UITableView) {
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid"
    let url = getBusURL(url: SeoulStationURL, params: ["arsId": arsId])
    
    AF.request(url,method: .get).validate()
        .responseString { response in
            print(" - API url: \(String(describing: response.request!))")
            
            //if case success
            switch response.result {
            case .success(let value):
                let responseString = NSString(data: response.data!, encoding:
                    String.Encoding.utf8.rawValue )
                let xml = try! XML.parse(String(responseString!))
                //self.myLabel.text=xml.text
                //print(responseString)
                var myBusList:[Bus]=[]
                for element in xml["ServiceResult"]["msgBody"]["itemList"] {
                    if let arrmsg1 = element["arrmsg1"].text, let arrmsg2 = element["arrmsg2"].text, let rtNm =
                        element["rtNm"].text, let adirection = element["adirection"].text, let nxtStn = element["nxtStn"].text {
                        print("stNm = \(arrmsg1), stId = \(arrmsg2), arsId = \(arsId), rtNm = \(rtNm), adirection = \(adirection)")
                        
                        var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: insertSpace(str: arrmsg1), firstBusCurrentLocation: nil, secondBusRemainingTime: insertSpace(str: arrmsg2), secondBusCurrentLocation: nil)
                        //var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                        myBusList.append(myBus)
                        myBusStop.direction = adirection
                    }
                    
                }
                var userSelectedBusList:[Bus] = myBusList.filter({ (bus) -> Bool in
                    return myBusStop.selectedBusList.contains(where: {(userSelectedBus) -> Bool in
                        return bus.busNumber == userSelectedBus.busNumber
                    })
                })
                
                myBusStop.selectedBusList = userSelectedBusList
                myBusStop.busList=myBusList
                
                
                DispatchQueue.main.async {
                    busFavoritesTV.reloadData()
                }
                
            //myBusStop = BusStop(name: mystNm!, direction: myadirection!, busList: myBusList)
            case .failure(let error):
                print(error)
            }
    }
}
