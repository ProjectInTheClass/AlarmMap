//
//  CallRouteAPI.swift
//  AlarmMap
//
//  Created by SeoungJun Oh on 2020/06/24.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyXMLParser

func getRoute(sx:Double, sy:Double, ex:Double, ey:Double, routeResultTV:UITableView?){
    ODsayService.sharedInst()?.setApiKey("jhU7uQHQE9+RWjclNfyu2Q")
    ODsayService.sharedInst()?.setTimeout(5000)
    
    let tempUserSelectedStartingPoint = userSelectedStartingPoint
    let tempUserSelectedDestinationPoint = userSelectedDestinationPoint
    userSelectedStartingPoint = WayPoint(placeholder: 0)
    userSelectedDestinationPoint = WayPoint(placeholder: 1)
    
    userSelectedStartingPoint.location.name = tempUserSelectedStartingPoint.location.name
    userSelectedDestinationPoint.location.name = tempUserSelectedDestinationPoint.location.name
    routeSearchList.removeAll()
    
    ODsayService.sharedInst()?.requestSearchPubTransPath(String(sx), sy: String(sy), ex: String(ex), ey: String(ey), opt: 0, searchType: 0, searchPathType: 0){
        (retCode:Int32, resultDic:[AnyHashable : Any]?) in
        if retCode == 200 {
            guard let myDict = resultDic else{
                print("fail")
                return
            }
            
            guard let result = myDict["result"] as? [AnyHashable : Any] else{
                print("result fail")
                return
            }
            
            guard let path = result["path"] as? NSArray else{
                print("path fail")
                return
            }
            
            var myPathList:[[AnyHashable:Any]] = []
            for element in path{
                myPathList.append(element as! [AnyHashable : Any])
            }
            
            for paths in myPathList{
                guard let info = paths["info"] as? [AnyHashable:Any] else{
                    print("info fail")
                    continue
                }
                
                guard let payment = info["payment"] else{
                    print("payment fail")
                    continue
                }
                
                guard let trafficDistance = info["trafficDistance"] else{
                    print("trafficDistance fail")
                    return
                }
                
                guard let totalWalk = info["totalWalk"] else{
                    print("totalWalk fail")
                    return
                }
                
                guard let totalTime = info["totalTime"] else{
                    print("totalTime fail")
                    return
                }
                
                guard let busTransitCount = info["busTransitCount"] else{
                    print("busTransitCount fail")
                    return
                }
                
                guard let subwayTransitCount = info["subwayTransitCount"] else{
                    print("subwayTransitCount fail")
                    return
                }
                
                
                
                guard let subPath = paths["subPath"] as? NSArray else{
                    print("subPath fail")
                    continue
                }
                
                var mySubPathList:[[AnyHashable:Any]] = []
                for element in subPath{
                    mySubPathList.append(element as! [AnyHashable : Any])
                }
                
                var myWayPointList:[WayPoint] = []
                let startWayPoint = tempUserSelectedStartingPoint
                myWayPointList.append(startWayPoint)
                
                for subPaths in mySubPathList{
                    guard let trafficType = subPaths["trafficType"] else{
                        print("trafficType fail")
                        continue
                    }
                    
                    guard let distance = subPaths["distance"] else{
                        print("distance fail")
                        continue
                    }
                    
                    guard let sectionTime = subPaths["sectionTime"] else{
                        print("sectionTime fail")
                        continue
                    }
                    
                    print(trafficType)
                    print(distance)
                    print(sectionTime)
                    
                    if trafficType as! Int == 3 {
                        myWayPointList.last!.distance = distance as! Double
                        myWayPointList.last!.takenSeconds = (sectionTime as! Int * 60)
                        continue
                    }
                    
                    guard let startName = subPaths["startName"] else{
                        print("startName fail")
                        continue
                    }
                    
                    guard let startX = subPaths["startX"] else{
                        print("startX fail")
                        continue
                    }
                    
                    guard let startY = subPaths["startY"] else{
                        print("startY fail")
                        continue
                    }
                    
                    guard let endName = subPaths["endName"] else{
                        print("endName fail")
                        continue
                    }
                    
                    guard let endX = subPaths["endX"] else{
                        print("endX fail")
                        continue
                    }
                    
                    guard let endY = subPaths["endY"] else{
                        print("endY fail")
                        continue
                    }
                    
                    guard let lane = subPaths["lane"] as? NSArray else{
                        print("lane fail")
                        continue
                    }
                    
                    var myLaneList:[[AnyHashable:Any]] = []
                    for element in lane{
                        myLaneList.append(element as! [AnyHashable : Any])
                    }
                    
                    let moveBy:MoveBy = trafficType as! Int == 1 ? .metro : .bus
                    var myStartNode:Node = Node()
                    var myEndNode:Node = Node()
                    
                    if trafficType as! Int == 2 {
                        var busNode:[Bus] = []
                        
                        for lanes in myLaneList {
                            guard let busNo = lanes["busNo"] else{
                                print("busNo fail")
                                continue
                            }
                            
                            busNode.append(Bus(busNumber: busNo as! String))
                        }
                        var myStartBusStop:BusStop = BusStop(name: startName as! String, arsId: nil, direction: nil, busList: [], selectedBusList: busNode)
                        var myEndBusStop:BusStop = BusStop(name: endName as! String, arsId: nil, direction: nil, busList: [Bus](), selectedBusList: [Bus]())
                        getRouteArsId(stSrch: startName as! String,myBusStop: myStartBusStop)
                        myStartNode = myStartBusStop
                        myEndNode = myEndBusStop
                        //myStartNode =  w2BusStop    //인증키부족때문에 임시로 설정
                        //myEndNode = w3BusStop
                    }
                    else {
                        guard let name = myLaneList[0]["name"] else{
                            print("name fail")
                            continue
                        }
                        
                        var lineName = name as! String
                        if lineName.contains("수도권"){
                            let range = lineName.index(lineName.startIndex, offsetBy: 4)...lineName.index(lineName.endIndex, offsetBy: -1)
                            lineName = String(lineName[range])
                        }
                        
                        if lineName == "자기부상철도"{
                            lineName = "자기부상"
                        }
                        else if lineName == "우이신설경전철"{
                            lineName = "우이신설선"
                        }
                        
                        var myStartMetroStation:MetroStation = MetroStation(name: startName as! String, line: lineName, direction: "미정", trainList: [Train]())
                        var myEndMeTroStation:MetroStation = MetroStation(name: endName as! String, line: lineName, direction: "미정", trainList: [Train]())
                        
                        myStartNode = myStartMetroStation
                        myEndNode = myEndMeTroStation
                        /*myStartNode = w4MetroStation
                        myEndNode = w4MetroStation*/
                    }
                    
                    var startWayPointRadius:Double = 50
                    var endWayPointRadius:Double = 50
                    
                    switch moveBy {
                    case .walk, .end:
                        startWayPointRadius = 300
                        endWayPointRadius = 300
                    case .bus:
                        startWayPointRadius = 150
                        endWayPointRadius = 100
                    case .metro:
                        startWayPointRadius = 250
                        endWayPointRadius = 300
                    }
                    
                    let subStartWayPoint:WayPoint = WayPoint(location: Location(name: startName as! String, latitude: startY as! Double, longitude: startX as! Double), type: moveBy, distance: distance as! Double, takenSeconds: (sectionTime as! Int * 60), onboarding: true, node: myStartNode, radius: startWayPointRadius)
                    let subEndWayPoint:WayPoint = WayPoint(location: Location(name: endName as! String, latitude: endY as! Double, longitude: endX as! Double), type: moveBy, distance: -1, takenSeconds: -1, onboarding: false, node: myEndNode, radius: endWayPointRadius)
                    
                    myWayPointList.append(subStartWayPoint)
                    myWayPointList.append(subEndWayPoint)
                    
                }
                
                let endWayPoint = tempUserSelectedDestinationPoint
                print("endwaypointof \(tempUserSelectedDestinationPoint.type)")
                myWayPointList.append(endWayPoint)
                
                var tmpcount:Int = 0
                
                var subwayTransferCount = subwayTransitCount as! Int
                var busTransferCount = busTransitCount as! Int
                
                var myRouteInfo:RouteInfo = RouteInfo(title: "내맘"+String(tmpcount), subtitle: "내맘"+String(tmpcount), startingPoint: startWayPoint, destinationPoint: endWayPoint, route: myWayPointList, scheduledDate: Date(), displacement: trafficDistance as! Double, time: totalTime as! Int, walk: totalWalk as! Int, cost: payment as! Int, transferCount: subwayTransferCount + busTransferCount - 1)
                tmpcount += 1
                
                routeSearchList.append(myRouteInfo)
            }
            
            routeResultTV?.reloadData()
            
        } else {
                print(resultDic!.description)
        }
    }
}

func getRouteArsId(stSrch: String, myBusStop:BusStop) {   //routeTab에서 정류소 정보를 받기 위한 API
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByName"
    let url = getBusURL(url: SeoulStationURL, params: ["stSrch": stSrch])
    
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
                    
                    if let arsId =
                        element["arsId"].text, let stNm = element["stNm"].text {
                        print("arsId = \(arsId)")
                        myBusStop.arsId = arsId
                        //getRouteBus(arsId: arsId, myBusStop : myBusStop)
                    }
                }
            
            case .failure(let error):
                print(error)
            }
    }
    
}

func getRouteBus(arsId: String, myBusStop:BusStop) {
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid"
    let url = getBusURL(url: SeoulStationURL, params: ["arsId": arsId])
    
    AF.request(url,method: .get).validate()
    .responseString { response in
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
                        //print("stNm = \(arrmsg1), stId = \(arrmsg2), arsId = \(arsId), rtNm = \(rtNm), adirection = \(adirection)")
                        
                        var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: insertSpace(str: arrmsg1), firstBusCurrentLocation: nil, secondBusRemainingTime: insertSpace(str: arrmsg2), secondBusCurrentLocation: nil)
                        //var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                        myBusList.append(myBus)
                        myBusStop.direction = adirection
                    }
                    
                }
                myBusStop.busList=myBusList

            case .failure(let error):
                print(error)
            }
    }
}
