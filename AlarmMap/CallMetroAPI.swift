//
//  CallMetroAPI.swift
//  AlarmMap
//
//  Created by SeoungJun Oh on 2020/06/02.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyXMLParser

func getMetroURL(url:String, params:[String: Any]) -> URL {
    let urlParams = params.compactMap({ (key, value) -> String in
    return "\(value)"
    }).joined(separator: "/")
    let withURL = url + "/\(urlParams)"
    let encoded = withURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! //+ "&serviceKey=" + metroKey
    return URL(string:encoded)!
}

func getMetroStationData(keyword:String, line:String, direction:String, myMetro:MetroStation){
    let SeoulStationURL = "http://swopenAPI.seoul.go.kr/api/subway"
    let url = getMetroURL(url: SeoulStationURL, params: ["key": metroKey+"/xml/realtimeStationArrival/0/40/"+keyword])//["key": metroKey, "xml": "xml","serviceName":"StationDayTrnsitNmpr","startIndex":1,"endIndex":5])

    
    
    AF.request(url,method: .get).validate()
    .responseString { response in
    print(" - API url: \(String(describing: response.request!))")

    //if case success
    switch response.result {
        case .success(let value):
                let responseString = NSString(data: response.data!, encoding:
                String.Encoding.utf8.rawValue )
                let xml = try! XML.parse(String(responseString!))
                print(responseString)
                
                
                for element in xml["realtimeStationArrival"]["row"] {
                    guard let subwayId = element["subwayId"].text else{
                        continue
                    }
                    guard let updnLine = element["updnLine"].text else{
                        continue
                    }
                    
                    if subwayId != lineTosubwayId(line: line) || updnLine != direction {
                        continue
                    }
                    
                    guard let arvlMsg2 = element["arvlMsg2"].text, let arvlMsg3 = element["arvlMsg3"].text, let statnNm = element["statnNm"].text, let bstatnNm = element["bstatnNm"].text else{
                        continue
                    }
                    
                    var myTrain:Train = Train(timeRemaining: arvlMsg2, currentStation: arvlMsg3, terminalStation: bstatnNm)
                    
                    myMetro.trainList.append(myTrain)
                }
                
                
        case .failure(let error):
            print(error)
            
        }
    }
    
}

func getTempData() {    //metroStationCandidates를 받아오거나 업데이트 하는 함수
    let SeoulStationURL = "http://openapi.seoul.go.kr:8088"
    let url = getMetroURL(url: SeoulStationURL, params: ["key": metroKey+"/xml/SearchSTNBySubwayLineInfo/1/728/"])
    print(url)
    AF.request(url,method: .get).validate()
    .responseString { response in
    print(" - API url: \(String(describing: response.request!))")

    //if case success
    switch response.result {
        case .success(let value):
                let responseString = NSString(data: response.data!, encoding:
                String.Encoding.utf8.rawValue )
                let xml = try! XML.parse(String(responseString!))
                //print(responseString)
                
                for element in xml["SearchSTNBySubwayLineInfo"]["row"] {
                    
                    if let STATION_NM =
                        element["STATION_NM"].text, let LINE_NUM = element["LINE_NUM"].text {
                        var myPair:MetroPair = MetroPair(name: STATION_NM, line: LINE_NUM)
                        metroStationCandidates.append(myPair)
                        /*if metroStationCandidates[STATION_NM] != nil{
                            metroStationCandidates[STATION_NM]!.append(LINE_NUM)
                        } else {
                            metroStationCandidates[STATION_NM] = [LINE_NUM]
                        }*/
                    }
                }
                print(metroStationCandidates)
                
        case .failure(let error):
            print(error)
        }
    }
}


/*func getAllMetroStationData(){  //실시간 지하철 api(알괄)을 통해 지하철 목록 받아오는 방법
    let SeoulStationURL = "http://swopenAPI.seoul.go.kr/api/subway"
    let url = getMetroURL(url: SeoulStationURL, params: ["key": metroKey+"/xml/realtimeStationArrival/ALL"])//["key": metroKey, "xml": "xml","serviceName":"StationDayTrnsitNmpr","startIndex":1,"endIndex":5])

    
    
    AF.request(url,method: .get).validate()
    .responseString { response in
    print(" - API url: \(String(describing: response.request!))")

    //if case success
    switch response.result {
        case .success(let value):
                let responseString = NSString(data: response.data!, encoding:
                String.Encoding.utf8.rawValue )
                let xml = try! XML.parse(String(responseString!))
                print(responseString)
                
                
                for element in xml["realtimeStationArrival"]["row"] {
                    guard let subwayId = element["subwayId"].text, let statnNm = element["statnNm"].text else{
                        print("fail")
                        continue
                    }
                    var t:String = subwayIdToLine(line: subwayId)
                    var flag:Bool = false
                    for i in allMetroStations{
                        if(i.name == statnNm && i.line == t){
                            flag = true
                            break
                        }
                    }
                    if(flag){
                        continue
                    }
                    let myPair:MetroPair=MetroPair(name: statnNm, line: t)
                    allMetroStations.append(myPair)
                }
                
                
        case .failure(let error):
            print(error)
            
        }
    }
    
}*/

//var allMetroStations:Array < MetroPair > = []
