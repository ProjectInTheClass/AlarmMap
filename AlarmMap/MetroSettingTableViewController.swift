//
//  MetroSettingTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/28.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import SwiftyXMLParser
import Alamofire

class MetroSettingTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
        //getAllMetroStationData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.isEditing = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.isEditing = false
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return metroStationList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetroSettingCell", for: indexPath) as! MetroSettingCell
        
        
        cell.lineLabel.text = metroStationList[indexPath.row].line
        cell.lineLabel.backgroundColor = lineColor(line: metroStationList[indexPath.row].line)
        cell.stationNameLabel.text = metroStationList[indexPath.row].name
        cell.directionLabel.text = metroStationList[indexPath.row].direction
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            metroStationList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            if let encoded = try? JSONEncoder().encode(metroStationList) {
                UserDefaults.standard.set(encoded, forKey: "metroStationList")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let metroStation = metroStationList.remove(at: sourceIndexPath.row)
        metroStationList.insert(metroStation, at: destinationIndexPath.row)
        if let encoded = try? JSONEncoder().encode(metroStationList) {
            UserDefaults.standard.set(encoded, forKey: "metroStationList")
        }
    }
    
}


