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
    
    var bsCandidates : Array < BusStop > = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busStopSearchBar = busStopSearchController.searchBar
        
        busStopSearchController.delegate = self
        busStopSearchBar?.delegate = self
        
        busStopSearchController.hidesNavigationBarDuringPresentation = false
        busStopSearchController.obscuresBackgroundDuringPresentation = false
        
        busStopSearchController.searchResultsUpdater=self
        
        busStopSearchController.searchBar.placeholder = "버스 정류장 입력"
        self.navigationItem.searchController = busStopSearchController
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    /*
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
    }*/
    
    func filterContentForSearchKeyword(_ searchKeyword: String) {
        if searchKeyword == ""{
            searchedBusStopList = busStopCandidates
        }
        else{
            var temp:Array < BusStop > = []
            
            for busStopPair in busStopCandidates{
                guard let bsName = busStopPair.name else{
                    continue
                }
                if bsName.contains(searchKeyword){
                    temp.append(busStopPair)
                }
            }
            searchedBusStopList = temp
        }
        tableView.reloadData()
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
        
        if let encoded = try? JSONEncoder().encode(busStopList) {
            UserDefaults.standard.set(encoded, forKey: "busStopList")
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchedBusStopList = []
        
        if(busStopCandidates.isEmpty){
            for t in busStopDict{
                var tBusStop=BusStop(name: t.value, arsId: t.key, direction: "", busList: [], selectedBusList: [])
                busStopCandidates.append(tBusStop)
                
            }
        }
        
        searchedBusStopList = busStopCandidates
        
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        busStopSearchController.isActive = true
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.busStopSearchController.searchBar.becomeFirstResponder()
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
        cell.busStopNameLabel.text = busStopName
        
        var busStopArsId = ""
        var busStopInfo = ""
        if let tempBusStopArsId =  searchedBusStopList[indexPath.row].arsId {
            busStopArsId = tempBusStopArsId
        }
        if let tempBusStopInfo = searchedBusStopList[indexPath.row].direction{
            busStopInfo = tempBusStopInfo + " 방면"
        }
        
        cell.busStopInfoLabel.text = "\(busStopArsId)"
        
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

extension BusStopAdditionTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKeyword = searchController.searchBar.text else{
            return
        }
        filterContentForSearchKeyword(searchKeyword)
    }
}
