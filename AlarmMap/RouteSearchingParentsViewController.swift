//
//  RouteSearchingParentsViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/10.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteSearchingParentsViewController: UIViewController {
    
    var searchResultTableView:UITableView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ODsayService.sharedInst()?.setApiKey("jhU7uQHQE9+RWjclNfyu2Q")
        ODsayService.sharedInst()?.setTimeout(5000)
        
        ODsayService.sharedInst()?.requestSearchPubTransPath("127.145909", sy: "37.478864", ex: "127.040152", ey: "37.558697", opt: 0, searchType: 0, searchPathType: 0){
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
                    var startWayPoint:WayPoint = WayPoint(placeholder: 0)
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
                            myWayPointList.last!.takenSeconds = sectionTime as! Int
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
                                    print("busNo faile")
                                    continue
                                }
                                
                                busNode.append(Bus(busNumber: busNo as! String))
                            }
                            var myStartBusStop:BusStop = BusStop(name: startName as! String, arsId: nil, direction: nil, busList: [], selectedBusList: busNode)
                            var myEndBusStop:BusStop = BusStop(name: endName as! String, arsId: nil, direction: nil, busList: [Bus](), selectedBusList: [Bus]())
                            getRouteArsId(stSrch: startName as! String,myBusStop: myStartBusStop)
                            myStartNode = myStartBusStop
                            myEndNode = myEndBusStop
                        }
                        else {
                            myStartNode = w4MetroStation
                            myEndNode = w4MetroStation
                        }
                        
                        
                        
                        var subStartWayPoint:WayPoint = WayPoint(location: Location(name: startName as! String, latitude: startX as! Double, longitude: startY as! Double), type: moveBy, distance: distance as! Double, takenSeconds: sectionTime as! Int, onboarding: true, node: myStartNode, radius: 50)
                        var subEndWayPoint:WayPoint = WayPoint(location: Location(name: endName as! String, latitude: endX as! Double, longitude: endY as! Double), type: moveBy, distance: -1, takenSeconds: -1, onboarding: false, node: myEndNode, radius: 50)
                        
                        myWayPointList.append(subStartWayPoint)
                        myWayPointList.append(subEndWayPoint)
                        
                    }
                    
                    var endWayPoint:WayPoint = WayPoint(placeholder: 1)
                    myWayPointList.append(endWayPoint)
                    
                    var tmpcount:Int = 0
                    
                    var subwayTransferCount = subwayTransitCount as! Int > 0 ? subwayTransitCount as! Int - 1 : 0
                    var busTransferCount = busTransitCount as! Int > 0 ? busTransitCount as! Int - 1 : 0
                    
                    var myRouteInfo:RouteInfo = RouteInfo(title: "내맘"+String(tmpcount), subtitle: "내맘"+String(tmpcount), startingPoint: startWayPoint, destinationPoint: endWayPoint, route: myWayPointList, scheduledDate: Date(), displacement: trafficDistance as! Double, time: totalTime as! Int, walk: totalWalk as! Int, cost: payment as! Int, transferCount: subwayTransferCount + busTransferCount)
                    tmpcount += 1
                    
                    routeSearchList.append(myRouteInfo)
                }
                
                
                
                /*guard let busCount = result["busCount"] as? NSNumber else{
                    print("뭔대")
                    print(result["busCount"])
                    return
                }
                //print(busCount.stringValue)
                //print(subwayBusCount)
                
                guard let path = result["path"] as? NSArray else{
                    print("뭔데2")
                    print(result["path"])
                    return
                }
                print("경로")
                print(path)
                
                var myPathList:[[AnyHashable:Any]] = []
                for element in path{
                    myPathList.append(element as! [AnyHashable : Any])
                }
                
                for paths in myPathList{
                    guard let info = paths["info"] as? [AnyHashable:Any] else{
                        print("fail")
                        continue
                    }
                    //print("인포")
                    //print(info)
                    guard let firstStartStation = info["firstStartStation"] else{
                        print("fail2")
                        continue
                    }
                    
                    print("드디어")
                    print(firstStartStation)
                    
                }*/
                //print(resultDic!.description)
            } else {
                    //print(resultDic!.description)
            }
        }
        
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(userSelectedStartingPoint.isAvailable() && userSelectedDestinationPoint.isAvailable())
        {
            //여기서 경로 검색하는 api 를 호출하면 됨. - 김요환
            // 0623 TODO - API가 호출되면 받아온 정보를 routeSearchList에 전달해야 함
            // for i in 0...(# of Routes) { routeSearchList[i] = APIResults[i] }
            /* 받아와야 하는 정보 (in ODSAY):
             @ totalDistance
             @ totalTime
             @ totalWalk (도보 이동 거리)
             @ payment
             @ subwayBusCount
             
             @ 경유지 정보 {
                이름, 위도, 경도
                subPath
                distance
                sectionTime
                승차/하차 여부
                either BusStop or MetroStation
                firstStartStation
                lastEndStation
            */
            searchResultTableView?.reloadData()
        }
        searchResultTableView?.reloadData()
    }
    
    // by CSEDTD - prepare()가 viewWillAppear()보다 먼저 실행
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "RouteSearchBarEmbedSegue"){
            //let routeSearchBarVC = segue.destination as! RouteSearchBarsViewController
            //routeSearchBarVC.startingPoint = self.startingPoint
            //routeSearchBarVC.destinationPoint = self.destinationPoint
        }
        else{ //RouteSearchResultEmbedSegue
            let routeSearchResultTVC = segue.destination as! RouteSearchResultTableViewController
            //routeSearchResultTVC.startingPoint = startingPoint
           // routeSearchResultTVC.destinationPoint = destinationPoint
            searchResultTableView = routeSearchResultTVC.tableView
        }
    }
    
    @IBAction func unwindRouteSearchingParentsVC (segue : UIStoryboardSegue) {
    
    }
}
