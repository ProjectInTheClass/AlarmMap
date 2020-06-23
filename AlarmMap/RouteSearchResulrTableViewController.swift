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
            
            // 0623 TODO
            //routeSettingTVC.tempRouteInfo.totalDisplacement = routeSearchList[senderCell.routeSearchResultIndex].totalDisplacement
            // etc...
            routeSettingTVC.tempRouteInfo = routeSearchList[senderCell.routeSearchResultIndex]
            
            //routeSettingTVC.tempRouteInfo.startingPoint = userSelectedStartingPoint
            //routeSettingTVC.tempRouteInfo.destinationPoint = userSelectedDestinationPoint
            
            userSelectedStartingPoint = WayPoint()
            userSelectedDestinationPoint = WayPoint()
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
        return routeSearchList.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendCustomRouteCell", for: indexPath) as! RecommendCustomRouteCell
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteSearchResultCell", for: indexPath) as! RouteSearchResultCell
            let routeInfo = routeSearchList[indexPath.row - 1]
            
            cell.routeSearchResultIndex = indexPath.row - 1
            
            cell.totalTimeLabel.text = "\(routeInfo.totalTime)분"
            cell.routeInfoLabel.text = "환승 \(routeInfo.transferCount)회 | 도보 \(routeInfo.totalWalk)분 | \(routeInfo.totalCost)원"
            
            cell.routePreviewBarView.myRouteInfo = routeSearchList[indexPath.row - 1]
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row != 0){
            let senderCell = tableView.cellForRow(at: indexPath)
            // 0623
            performSegue(withIdentifier: "unwindRouteSettingTVC", sender: senderCell)
        }
    }

}
