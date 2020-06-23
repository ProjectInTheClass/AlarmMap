//
//  RouteDetailInfoTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/21.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteDetailInfoTableViewController: UITableViewController {
    
    var myRouteInfo:RouteInfo? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemGray5
               let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 30))
               footerView.backgroundColor = UIColor.systemGray5
               self.tableView.tableFooterView = footerView
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRouteInfo!.route.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch myRouteInfo!.route[indexPath.row].type {
        case .walk: //출발지
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteWalkCell", for: indexPath) as! RouteWalkCell
            let waypoint = myRouteInfo!.route.first!
            
            cell.locationSymbolImageView.image = UIImage(systemName: "mappin.and.ellipse", withConfiguration: .none)
            cell.locationSymbolImageView.tintColor = .black
            
            cell.routeDetailLeftView.waypoint = waypoint
            
            cell.locationNameLabel.text = waypoint.location.name
            cell.locationInfoLabel.text = ""
            cell.walkTimeAndDistLabel.text = "도보 \(Int(round( Double(waypoint.takenSeconds)/60.0)))분 | \(Int(waypoint.distance))m"
            
            return cell
            
        case .bus: //버스 승하차
            let waypoint = myRouteInfo!.route[indexPath.row]
            
            if(waypoint.onboarding){
                let cell = tableView.dequeueReusableCell(withIdentifier: "RouteBusCell", for: indexPath) as! RouteBusCell
                let busStop = waypoint.node as! BusStop
                
                cell.routeDetailLeftView.waypoint = waypoint
                
                cell.busStopNameLabel.text = busStop.name! + " 승차"
                cell.busStopIdLabel.text = busStop.arsId
                
                cell.busListLabel.text = busStop.selectedBusList.reduce("", {(busListText, bus) -> String in
                    return busListText + bus.busNumber + " "
                })
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RouteWalkCell", for: indexPath) as! RouteWalkCell
                let busStop = waypoint.node as! BusStop
                
                cell.locationSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: .none)
                cell.locationSymbolImageView.tintColor = .systemBlue
                
                cell.routeDetailLeftView.waypoint = waypoint
                
                cell.locationNameLabel.text = busStop.name! + " 하차"
                cell.locationInfoLabel.text = busStop.arsId
                cell.walkTimeAndDistLabel.text = "도보 \(Int(round( Double(waypoint.takenSeconds)/60.0)))분 | \(Int(waypoint.distance))m"
                
                return cell
            }
            
        case .metro: //지하철 승하차
            let waypoint = myRouteInfo!.route[indexPath.row]
            
            if(waypoint.onboarding){
                let cell = tableView.dequeueReusableCell(withIdentifier: "RouteMetroCell", for: indexPath) as! RouteMetroCell
                let metroStation = waypoint.node as! MetroStation
                
                cell.metroSymbolImageView.tintColor = lineColor(line: metroStation.line)
                
                cell.routeDetailLeftView.waypoint = waypoint
                
                cell.metroStationNameLabel.text = metroStation.name + " 승차"
                cell.metroStationInfoLabel.text = metroStation.direction
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "RouteWalkCell", for: indexPath) as! RouteWalkCell
                let metroStation = waypoint.node as! MetroStation
                
                cell.locationSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: .none)
                cell.locationSymbolImageView.tintColor = lineColor(line: metroStation.line)
                
                cell.routeDetailLeftView.waypoint = waypoint
                
                cell.locationNameLabel.text = metroStation.name + " 하차"
                cell.locationInfoLabel.text = "내리는 문:왼쪽(이거 임시값)"
                if(waypoint.distance == 0){
                    cell.walkTimeAndDistLabel.text = "환승"
                }
                else{
                    cell.walkTimeAndDistLabel.text = "도보 \(Int(round( Double(waypoint.takenSeconds)/60.0)))분 | \(Int(waypoint.distance))m"
                }
                
                return cell
            }
                
        case .end: //도착지
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteEndCell", for: indexPath) as! RouteEndCell
            
            cell.locationSymbolImageView.image = UIImage(systemName: "mappin.and.ellipse", withConfiguration: .none)
            cell.locationSymbolImageView.tintColor = .systemRed
            
            cell.routeDetailLeftView.waypoint = myRouteInfo!.route.last!
            
            cell.locationNameLabel.text = myRouteInfo!.route.last!.location.name
            
            return cell
        }
        
    }

}
