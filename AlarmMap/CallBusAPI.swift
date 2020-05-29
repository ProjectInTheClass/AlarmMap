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

func getURL(url:String, params:[String: Any]) -> URL {
    let urlParams = params.compactMap({ (key, value) -> String in
    return "\(key)=\(value)"
    }).joined(separator: "&")
    let withURL = url + "?\(urlParams)"
    let encoded = withURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&serviceKey=" + busKey
    return URL(string:encoded)!
}

func getStationData(stSrch: String) {
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByName"
    let url = getURL(url: SeoulStationURL, params: ["stSrch": stSrch])
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
                //var myBusStopList:[BusStop]=[]
                for element in xml["ServiceResult"]["msgBody"]["itemList"] {
                    /*if let stNm = element["stNm"].text, let stId = element["stId"].text, let arsId =
                        element["arsId"].text {
                        print("stNm = \(stNm), stId = \(stId), arsId = \(arsId)")
                    }*/
                    var myBus=BusStop(name: nil, arsId: nil, direction: nil, busList: nil)
                    busStopList.append(myBus)
                    if let arsId =
                        element["arsId"].text, let stNm = element["stNm"].text {
                        print("arsId = \(arsId)")
                        myBus.name = stNm
                        myBus.arsId = arsId
                        getStation(arsId: arsId,myBusStop : myBus)
                        //myBusStopList.append(myBusStop!)
                    }
                }
                //for bsl in myBusStopList{
                    //print(bsl)
        //}
        case .failure(let error):
            print(error)
        }
    }
}

func getStation(arsId: String, myBusStop:BusStop) {
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid"
    let url = getURL(url: SeoulStationURL, params: ["arsId": arsId])
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
                        
                        var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                        //var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                        myBusList.append(myBus)
                        myBusStop.direction = adirection
                    }
                
                }
                myBusStop.busList=myBusList
                for bsl in busStopList{
                    print("mybsl")
                }
                //myBusStop = BusStop(name: mystNm!, direction: myadirection!, busList: myBusList)
        case .failure(let error):
            print(error)
        }
    }
}



func refreshStation(arsId: String, myBusStop:BusStop) {
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid"
    let url = getURL(url: SeoulStationURL, params: ["arsId": arsId])
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
                        
                        var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                        //var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                        myBusList.append(myBus)
                        myBusStop.direction = adirection
                    }
                
                }
                myBusStop.busList=myBusList
                for bsl in busStopList{
                    print("mybsl")
                }
                //myBusStop = BusStop(name: mystNm!, direction: myadirection!, busList: myBusList)
        case .failure(let error):
            print(error)
        }
    }
}
