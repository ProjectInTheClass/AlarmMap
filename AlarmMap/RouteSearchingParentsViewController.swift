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

}
