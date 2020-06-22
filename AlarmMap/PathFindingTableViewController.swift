//
//  PathFindingTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class PathFindingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return workingAlarm.routeIndex >= 0 ? 2 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var waypoint:WayPoint
        if(workingAlarm.routeIndex == 0){
            waypoint = section == 0 ? workingAlarm.route[0] : workingAlarm.route[1]
        }
        else{
            waypoint = section == 0 ? workingAlarm.route[workingAlarm.routeIndex-1] : workingAlarm.route[workingAlarm.routeIndex]
        }
        
        switch waypoint.type {
        case .walk, .end:
            return 2
        case .metro:
            return waypoint.onboarding ? 3 : 2
        case .bus:
            if (waypoint.onboarding){
                let busStop = waypoint.node as! BusStop
                return 2 + busStop.selectedBusList.count
            }
            else{
                return 2
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var waypoint:WayPoint
        if(workingAlarm.routeIndex == 0){
            waypoint = indexPath.section == 0 ? workingAlarm.route[0] : workingAlarm.route[1]
        }
        else{
            waypoint = indexPath.section == 0 ? workingAlarm.route[workingAlarm.routeIndex-1] : workingAlarm.route[workingAlarm.routeIndex]
        }
        
        switch waypoint.type {
        case .walk:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PathFindingTitleCell", for: indexPath) as! PathFindingTitleCell
            
            cell.titleLabel.text = indexPath.row == 0 ? "출발" : waypoint.location.name
            
            return cell
        case .end:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PathFindingTitleCell", for: indexPath) as! PathFindingTitleCell
            
            cell.titleLabel.text = indexPath.row == 0 ? "도착" : waypoint.location.name
            
            return cell
        case .bus:
            let busStop = waypoint.node as! BusStop
            if(waypoint.onboarding){
                if(indexPath.row == 0){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PathFindingTitleCell", for: indexPath) as! PathFindingTitleCell
                    
                    cell.titleLabel.text = "승차"
                    
                    return cell
                }
                else if(indexPath.row == 1){ // BusStopCell
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopCell", for: indexPath) as! BusStopCell
                    
                    cell.busStopNameLabel.text = busStop.name
                    cell.busStopDirectionLabel.text = "\(busStop.arsId!) | \(busStop.direction!) 방면"
                    
                    return cell
                }
                else{ //BusCell
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BusCell", for: indexPath) as! BusCell
                    
                    cell.busNumberLabel.text = busStop.selectedBusList[indexPath.row - 2].busNumber
                    
                    return cell
                }
                
            }
            else{
                if(indexPath.row == 0){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PathFindingTitleCell", for: indexPath) as! PathFindingTitleCell
                    
                    cell.titleLabel.text = "하차"
                    
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopCell", for: indexPath) as! BusStopCell
                    
                    cell.busStopNameLabel.text = busStop.name
                    cell.busStopDirectionLabel.text = busStop.arsId
                    
                    return cell
                }
            }
        case .metro:
            let metroStation = waypoint.node as! MetroStation
            if(waypoint.onboarding){
                if(indexPath.row == 0){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PathFindingTitleCell", for: indexPath) as! PathFindingTitleCell
                    
                    cell.titleLabel.text = "승차"
                    
                    return cell
                }
                else if(indexPath.row == 1){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MetroStationCell", for: indexPath) as! MetroStationCell
                    
                    cell.lineLabel.text = metroStation.line
                    cell.StationNameLabel.text = metroStation.name
                    cell.directionLabel.text = metroStation.direction + " 방면"
                    
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TrainsCell", for: indexPath) as! TrainsCell
                    
                    cell.firstTrainRemainingTimeLabel.text = metroStation.trainList[0].timeRemaining
                    cell.secondTrainRemainingTimeLabel.text = metroStation.trainList[1].timeRemaining
                    
                    return cell
                }
            }
            else{
                if(indexPath.row == 0){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PathFindingTitleCell", for: indexPath) as! PathFindingTitleCell
                    
                    cell.titleLabel.text = "하차"
                    
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MetroStationCell", for: indexPath) as! MetroStationCell
                    
                    cell.lineLabel.text = metroStation.line
                    cell.StationNameLabel.text = metroStation.name
                    cell.directionLabel.text = ""
                    
                    return cell
                }
            }
        }
        
    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }

}
