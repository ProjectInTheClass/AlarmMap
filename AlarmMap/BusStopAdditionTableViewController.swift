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

class BusStopAdditionTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    var busStopSearchBar:UISearchBar? = nil
    let busStopSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busStopSearchBar = busStopSearchController.searchBar
        
        busStopSearchBar?.delegate = self
        
        busStopSearchController.hidesNavigationBarDuringPresentation = false
        busStopSearchController.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = busStopSearchController
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (busStopSearchBar?.text != ""){
            let keyword = busStopSearchBar?.text
            
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
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let addButton = sender as! UIButton
        addButton.isSelected = !addButton.isSelected
        
        let additionCell = addButton.superview?.superview?.superview as! BusStopAdditionCell
        
        if(addButton.isSelected){
            busStopList.append(searchedBusStopList[additionCell.cellIndex])
        }
        else{
            for (index,busStop) in busStopList.enumerated() {
                if(busStop.arsId == additionCell.arsId){
                    busStopList.remove(at: index)
                    break
                }
            }
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchedBusStopList = []
        tableView.reloadData()
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
        cell.cellIndex = indexPath.row
        cell.arsId = searchedBusStopList[indexPath.row].arsId
        cell.addButton.isSelected = false
        
        for busStop in busStopList {
            if(busStop.arsId == cell.arsId){
                cell.addButton.isSelected = true
                break
            }
        }
        
        return cell
    }
    
}
