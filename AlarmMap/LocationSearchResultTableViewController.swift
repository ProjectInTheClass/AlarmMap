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
            
            if(isStartingLocationSearching){
                routeSearchingParentsVC.startingLocation = locationSearchList[senderCell.cellIndex]
            }
            else{
                routeSearchingParentsVC.destinationLocation = locationSearchList[senderCell.cellIndex]
                
                print("얘는 언윈드세그")
                print(locationSearchList[senderCell.cellIndex].title)
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
        return locationSearchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationSearchResultCell", for: indexPath) as! LocationSearchResultCell
        
        cell.locationNameLabel.text = locationSearchList[indexPath.row].title
        cell.locationInfoLabel.text = locationSearchList[indexPath.row].nickname
        
        cell.cellIndex = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "unwindRouteSearchingParentsVCSegue", sender: tableView.cellForRow(at: indexPath))
    }


}
