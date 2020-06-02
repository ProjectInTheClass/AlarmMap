//
//  BusStopAdditionTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/28.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import SwiftyXMLParser
import Alamofire

class BusStopAdditionTableViewController: UITableViewController {
    
    @IBOutlet var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        if (searchTextField.text != ""){
            let keyword = searchTextField.text
            
            searchedBusStopList = []
            
            let getBusDataDispatchGroup = DispatchGroup()
            
            getBusDataDispatchGroup.enter()
            DispatchQueue.main.async {
                getBusStationData(stSrch: keyword!, group:getBusDataDispatchGroup)
            }
            
            getBusDataDispatchGroup.notify(queue: .main, execute: {
                self.tableView.reloadData()
            })
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchedBusStopList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopAdditionCell", for: indexPath) as! BusStopAdditionCell
        
        guard let busStopName = searchedBusStopList[indexPath.row].name else{
            cell.busStopNameLabel.text = "값을 불러오는데 실패하였습니다"
            return cell
        }
        cell.busStopNameLabel.text=busStopName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        busStopList.append(searchedBusStopList[indexPath.row])
    }
    
}
