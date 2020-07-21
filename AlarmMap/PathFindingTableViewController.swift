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
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
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
            return waypoint.onboarding ? 5 : 2
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
            if(indexPath.row == 0){
                return getPathFindingTitleCell(title: "출발", indexPath: indexPath)
            }
            else{
                return getPathEndPointCell(locationName: waypoint.location.name, indexPath: indexPath)
            }
        case .end:
            if(indexPath.row == 0){
                return getPathFindingTitleCell(title: "도착", indexPath: indexPath)
            }
            else{
                return getPathEndPointCell(locationName: waypoint.location.name, indexPath: indexPath)
            }
        case .bus:
            let busStop = waypoint.node as! BusStop
            if(waypoint.onboarding){
                if(indexPath.row == 0){
                    return getPathFindingTitleCell(title: "승차", indexPath: indexPath)
                }
                else if(indexPath.row == 1){ // BusStopCell
                    return getBusStopCell(busStop: busStop, indexPath: indexPath)
                }
                else{ //BusCell
                    return getBusCell(busStop: busStop, indexPath: indexPath)
                }
                
            }
            else{
                if(indexPath.row == 0){
                    return getPathFindingTitleCell(title: "하차", indexPath: indexPath)
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
                    return getPathFindingTitleCell(title: "승차", indexPath: indexPath)
                }
                else if(indexPath.row == 1 || indexPath.row == 3){
                    return getMetroSationCell(metroStation: metroStation, indexPath: indexPath)
                }
                else{
                    return getTrainsCell(metroStation: metroStation, indexPath: indexPath)
                }
            }
            else{
                if(indexPath.row == 0){
                    return getPathFindingTitleCell(title: "하차", indexPath: indexPath)
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
    
    
    // MARK: - 테이블뷰 셀 return하는 함수들
    func getPathFindingTitleCell(title:String, indexPath:IndexPath) -> PathFindingTitleCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PathFindingTitleCell", for: indexPath) as! PathFindingTitleCell
        
        cell.titleLabel.text = title
        
        return cell
    }
    
    func getPathEndPointCell(locationName:String, indexPath:IndexPath) -> PathEndPointCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PathEndPointCell", for: indexPath) as! PathEndPointCell
        
        cell.locationNameLabel.text = locationName
        
        return cell
    }
    
    func getBusStopCell(busStop:BusStop, indexPath:IndexPath) -> BusStopCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopCell", for: indexPath) as! BusStopCell
        
        cell.busStopNameLabel.text = busStop.name
        if let arsId = busStop.arsId, let direction = busStop.direction{
            cell.busStopDirectionLabel.text = "\(arsId) | \(direction) 방면"
        } else{
            cell.busStopDirectionLabel.text = "API키 횟수 제한"
        }
        
        
        return cell
    }
    
    func getBusCell(busStop:BusStop, indexPath:IndexPath) -> BusCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusCell", for: indexPath) as! BusCell
        
        cell.busNumberLabel.text = busStop.selectedBusList[indexPath.row - 2].busNumber
        
        cell.firstBusRemainingTimeLabel.text = busStop.selectedBusList[indexPath.row - 2].firstBusRemainingTime
        cell.firstBusCurrentLocationLabel.text = busStop.selectedBusList[indexPath.row - 2].firstBusCurrentLocation
        
        return cell
    }
    
    func getMetroSationCell(metroStation:MetroStation, indexPath:IndexPath) -> MetroStationCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetroStationCell", for: indexPath) as! MetroStationCell
        
        cell.lineLabel.text = metroStation.line
        cell.StationNameLabel.text = metroStation.name
        
        if(metroStation.line == "2호선"){
            cell.directionLabel.text = indexPath.row == 1 ? "내선" : "외선"
        }
        else{
            cell.directionLabel.text = indexPath.row == 1 ? "상행" : "하행"
        }
        
        cell.lineLabel.backgroundColor = lineColor(line: metroStation.line)
        
        return cell
    }
    
    func getTrainsCell(metroStation:MetroStation, indexPath:IndexPath) -> TrainsCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainsCell", for: indexPath) as! TrainsCell
        
        var metroStation:MetroStation
        
        if(indexPath.row == 2){
            metroStation = pathFindingMetroStations[0]
        }
        else{
            metroStation = pathFindingMetroStations[1]
        }
        
        if(metroStation.trainList.count > 0){
            cell.firstTrainRemainingTimeLabel.text = metroStation.trainList[0].timeRemaining
            cell.firstTrainCurrentStationLabel.text = metroStation.trainList[0].currentStation
            cell.firstTrainTerminalStationLabel.text = metroStation.trainList[0].terminalStation
            cell.firstTrainView.backgroundColor = lineColor(line: metroStation.line)
        }
        
        if(metroStation.trainList.count > 1){
            cell.secondTrainRemainingTimeLabel.text = metroStation.trainList[1].timeRemaining
            cell.secondTrainCurrentStationLabel.text = metroStation.trainList[1].currentStation
            cell.secondTrainTerminalStationLabel.text = metroStation.trainList[1].terminalStation
            cell.secondTrainView.backgroundColor = lineColor(line: metroStation.line)
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
