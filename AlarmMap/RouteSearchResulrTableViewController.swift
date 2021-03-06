//
//  RouteSearchingTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/28.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteSearchResultTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "unwindRouteSettingTVC"){
            let routeSettingTVC = segue.destination as! RouteSettingTableViewController
            let senderCell = (sender as! RouteSearchResultCell)
            // 0623
            routeSettingTVC.routeSelected = true
            routeSettingTVC.routeChanged = true
            
            // 0623 TODO
            //routeSettingTVC.tempRouteInfo.route = routeSearchList[senderCell.routeSearchResultIndex].route
            //routeSettingTVC.tempRouteInfo.totalDisplacement = routeSearchList[senderCell.routeSearchResultIndex].totalDisplacement
            //routeSettingTVC.tempRouteInfo.totalTime = routeSearchList[senderCell.routeSearchResultIndex].totalTime
            //routeSettingTVC.tempRouteInfo.totalWalk = routeSearchList[senderCell.routeSearchResultIndex].totalWalk
            //routeSettingTVC.tempRouteInfo.totalCost = routeSearchList[senderCell.routeSearchResultIndex].totalCost
            //routeSettingTVC.tempRouteInfo.transferCount = routeSearchList[senderCell.routeSearchResultIndex].transferCount
            routeSettingTVC.tempRouteInfo = routeSearchList[senderCell.routeSearchResultIndex]
            
            //routeSettingTVC.tempRouteInfo.startingPoint = userSelectedStartingPoint
            //routeSettingTVC.tempRouteInfo.destinationPoint = userSelectedDestinationPoint
            
            userSelectedStartingPoint = WayPoint(placeholder: 0)
            userSelectedDestinationPoint = WayPoint(placeholder: 1)
        }
        else{ //routeDetailInfoSeguea
            let senderButton = sender as! UIButton
            let cell = senderButton.superview?.superview?.superview as! RouteSearchResultCell
            let routeDetailInfoTVC = segue.destination as! RouteDetailInfoTableViewController
            
            routeDetailInfoTVC.myRouteInfo = routeSearchList[cell.routeSearchResultIndex]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routeSearchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteSearchResultCell", for: indexPath) as! RouteSearchResultCell
        let routeInfo = routeSearchList[indexPath.row]
        
        cell.routeSearchResultIndex = indexPath.row
        
        cell.totalTimeLabel.text = "\(routeInfo.totalTime)분"
        cell.routeInfoLabel.text = "환승 \(routeInfo.transferCount)회 | 도보 \(routeInfo.totalWalk/60)분 | \(routeInfo.totalCost)원"
        
        cell.routePreviewBarView.myRouteInfoIndex = indexPath.row
        
        cell.routePreviewBarView.setNeedsDisplay()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let senderCell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "unwindRouteSettingTVC", sender: senderCell)
    }

}
