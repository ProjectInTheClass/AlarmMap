//
//  PlaceSearchResultTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/11.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class LocationSearchResultTableViewController: UITableViewController {
    
    var isStartingLocationSearching = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "unwindRouteSearchingParentsVCSegue"){
            let routeSearchingParentsVC = segue.destination as! RouteSearchingParentsViewController
            
            let senderCell = sender as! LocationSearchResultCell
            
            // 0611
            if(isStartingLocationSearching){
                routeSearchingParentsVC.startingLocation = waypointSearchList[senderCell.cellIndex].location
                    //locationSearchList[senderCell.cellIndex]
            }
            // 0611
            else{
                routeSearchingParentsVC.destinationLocation = waypointSearchList[senderCell.cellIndex].location
                    //locationSearchList[senderCell.cellIndex]
                
                print("얘는 언윈드세그")
                // 0611
                print(waypointSearchList[senderCell.cellIndex].location.name)
                //print(locationSearchList[senderCell.cellIndex].title)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // 0611
        return waypointSearchList.count
        //return locationSearchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationSearchResultCell", for: indexPath) as! LocationSearchResultCell
        
        // 0611
        cell.locationNameLabel.text = waypointSearchList[indexPath.row].location.name
            //locationSearchList[indexPath.row].title
        cell.locationInfoLabel.text = "이 label 지웁시다"
            //locationSearchList[indexPath.row].nickname
        
        cell.cellIndex = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "unwindRouteSearchingParentsVCSegue", sender: tableView.cellForRow(at: indexPath))
    }


}
