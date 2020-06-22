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
        
        /*ODsayService.sharedInst()?.setApiKey("jhU7uQHQE9+RWjclNfyu2Q")
        ODsayService.sharedInst()?.setTimeout(5000)
        
        ODsayService.sharedInst()?.requestSearchPubTransPath("127.145909", sy: "37.478864", ex: "127.040152", ey: "37.558697", opt: 0, searchType: 0, searchPathType: 0){
            (retCode:Int32, resultDic:[AnyHashable : Any]?) in
            if retCode == 200 {
                guard let myDict = resultDic else{
                    return
                }
                
                guard let result = myDict["result"] as? [AnyHashable : Any] else{
                    return
                }
                print("여기")
                print(result)
                guard let busCount = result["busCount"] as? NSNumber else{
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
                    
                }
                //print(resultDic!.description)
            } else {
                    //print(resultDic!.description)
            }
        }
        for i in routeSearchList{
            print("kkkk")
            print(i)
        }*/
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(userSelectedStartingPoint.isAvailable() && userSelectedDestinationPoint.isAvailable())
        {
            //여기서 경로 검색하는 api 를 호출하면 됨. - 김요환
            searchResultTableView?.reloadData()
        }
        
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
