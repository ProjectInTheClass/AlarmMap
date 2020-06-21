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
        if(indexPath.row == 0){ //출발지
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteWalkCell", for: indexPath) as! RouteWalkCell
            
            cell.locationSymbolImageView.image = UIImage(systemName: "mappin", withConfiguration: .none)
            cell.locationNameLabel.text = myRouteInfo!.route.first!.location.name
            cell.walkTimeAndDistLabel.text = "도보 \(round( Double(myRouteInfo!.route.first!.takenSeconds)/60.0))분 | \(Int(myRouteInfo!.route.first!.distance))m"
            
            return cell
        }
        else {
            switch myRouteInfo!.route[indexPath.row].type {
            case .walk: //정류장 or 역에서 하차
                let cell = tableView.dequeueReusableCell(withIdentifier: "RouteWalkCell", for: indexPath) as! RouteWalkCell
                
                cell.locationSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: .none)
                
                let prevWayPoint = myRouteInfo!.route[indexPath.row - 1]
                let prevType = prevWayPoint.type
                if(prevType == .bus){
                    var prevBusStop = prevWayPoint.node as! BusStop
                    //cell.locationSymbolImageView.tintColor = prevBusStop.selectedBusList![0].type.getColor()
                }
                else{ //.metro
                    var prevMetroStation = prevWayPoint.node as! MetroStation
                    //cell.locationSymbolImageView.tintColor = prevMetroStation.line.getColor()
                }
                
                cell.locationNameLabel.text = myRouteInfo!.route[indexPath.row].location.name + " 하차"
                cell.walkTimeAndDistLabel.text = "도보 \(round( Double(myRouteInfo!.route[indexPath.row].takenSeconds)/60.0))분 | \(Int(myRouteInfo!.route[indexPath.row].distance))m"
                
                return cell
            case .metro: //지하철 승차
                print(1)
            case .bus: //버스 승차
                let cell = tableView.dequeueReusableCell(withIdentifier: "RouteBusCell", for: indexPath) as! RouteBusCell
                
                let busStop = myRouteInfo!.route[indexPath.row].node as! BusStop
                cell.busStopNameLabel.text = busStop.name! + " 승차"
                cell.busStopIdLabel.text = busStop.arsId
                cell.busListLabel.text = busStop.selectedBusList![0].busNumber
                
                return cell
            case .end: //도착지
                let cell = tableView.dequeueReusableCell(withIdentifier: "RouteEndCell", for: indexPath) as! RouteEndCell
                
                cell.locationSymbolImageView.image = UIImage(systemName: "mappin.and.ellipse", withConfiguration: .none)
                cell.locationSymbolImageView.tintColor = .red
                
                cell.locationNameLabel.text = myRouteInfo!.route.last!.location.name
                
                return cell
            }
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteWalkCell", for: indexPath) as! RouteWalkCell
        
        cell.locationNameLabel.text = "dummy"
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
