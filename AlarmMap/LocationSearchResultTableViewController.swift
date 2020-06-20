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
        
        if(isStartingLocationSearching){
            userSelectedStartingPoint = waypointSearchList[indexPath.row]
        }
        else{
            userSelectedDestinationPoint = waypointSearchList[indexPath.row]
        }
        
        self.navigationController?.popViewController(animated: true)
        //performSegue(withIdentifier: "unwindRouteSearchingParentsVCSegue", sender: tableView.cellForRow(at: indexPath))
    }


}
