//
//  MetroStationAdditionTableViewController.swift
//  AlarmMap
//
//  Created by SeoungJun Oh on 2020/06/08.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class MetroStationAdditionTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    var metroStationSearchBar:UISearchBar? = nil
    let metroStationSearchController = UISearchController()
    
    var candidates:Array<MetroPair> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*print(allMetroStations)   실시간 지하철 정보(일괄) 데이터 받아오는 실험 예시
         print("size"+String(allMetroStations.count))
         allMetroStations = allMetroStations.sorted(by: {$0.name < $1.name})
         print(allMetroStations)*/
        metroStationSearchBar = metroStationSearchController.searchBar
        metroStationSearchBar?.delegate = self
        metroStationSearchController.delegate = self
        metroStationSearchController.searchResultsUpdater=self
        metroStationSearchController.hidesNavigationBarDuringPresentation = false
        metroStationSearchController.obscuresBackgroundDuringPresentation = false
        metroStationSearchController.searchBar.placeholder = "지하철 입력"
        navigationItem.searchController = metroStationSearchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        candidates = metroStationCandidates
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        metroStationSearchController.isActive = true
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.metroStationSearchController.searchBar.becomeFirstResponder()
        }
    }
    
    // MARK: - Table view data source
    
    func filterContentForSearchKeyword(_ searchKeyword: String) {
        if searchKeyword == ""{
            candidates = metroStationCandidates
        }
        else{
            var temp:Array < MetroPair > = []
            
            for metroPair in metroStationCandidates{
                if metroPair.name.contains(searchKeyword){
                    temp.append(metroPair)
                }
            }
            candidates = temp
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return candidates.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetroStationAdditionCell", for: indexPath) as! MetroStationAdditionCell
        
        // Configure the cell...
        
        cell.lineLabel.text = candidates[indexPath.row].line
        cell.lineLabel.backgroundColor = lineColor(line: candidates[indexPath.row].line)
        cell.stationNameLabel.text = candidates[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chooseDirection = UIAlertController(title: "방향 선택", message: "방향을 선택해주세요", preferredStyle: .actionSheet)
        
        let registeredStationError = UIAlertController(title: "등록 실패", message: "이미 등록되어있는 지하철 역 입니다", preferredStyle: .alert)
        
        
        let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        registeredStationError.addAction(confirm)
        
        let cellName = candidates[indexPath.row].name
        let cellLine = candidates[indexPath.row].line
        
        if cellLine == "2호선" {
            let clockwiseDirection = UIAlertAction(title: "내선(시계 방향)", style: .default, handler: {(action:UIAlertAction) -> Void in
                for existingStation in metroStationList{
                    if existingStation.name == cellName && existingStation.line == cellLine && existingStation.direction == "내선"{
                        self.present(registeredStationError, animated: true, completion: nil)
                        return
                    }
                }
                
                var myMetro = MetroStation(name: cellName, line: cellLine, direction: "내선", trainList: [])
                metroStationList.append(myMetro)
                
                if let encoded = try? JSONEncoder().encode(metroStationList) {
                    UserDefaults.standard.set(encoded, forKey: "metroStationList")
                }
                
                getMetroStationData(keyword: cellName, line: cellLine, direction: "내선", myMetro: myMetro)
            })
            
            let counterClockwiseDirection = UIAlertAction(title: "외선(시계 반대 방향)", style: .default, handler: {(action:UIAlertAction) -> Void in
                for existingStation in metroStationList{
                    if existingStation.name == cellName && existingStation.line == cellLine && existingStation.direction == "외선"{
                        self.present(registeredStationError, animated: true, completion: nil)
                        return
                    }
                }
                
                var myMetro = MetroStation(name: cellName, line: cellLine, direction: "외선", trainList: [])
                metroStationList.append(myMetro)
                
                if let encoded = try? JSONEncoder().encode(metroStationList) {
                    UserDefaults.standard.set(encoded, forKey: "metroStationList")
                }
                getMetroStationData(keyword: cellName, line: cellLine, direction: "외선", myMetro: myMetro)
            })
            chooseDirection.addAction(clockwiseDirection)
            chooseDirection.addAction(counterClockwiseDirection)
        }
        else {
            let upDirection = UIAlertAction(title: "상행", style: .default, handler: {(action:UIAlertAction) -> Void in
                for existingStation in metroStationList{
                    if existingStation.name == cellName && existingStation.line == cellLine && existingStation.direction == "상행"{
                        self.present(registeredStationError, animated: true, completion: nil)
                        return
                    }
                }
                
                var myMetro = MetroStation(name: cellName, line: cellLine, direction: "상행", trainList: [])
                metroStationList.append(myMetro)
                
                if let encoded = try? JSONEncoder().encode(metroStationList) {
                    UserDefaults.standard.set(encoded, forKey: "metroStationList")
                }
                getMetroStationData(keyword: cellName, line: cellLine, direction: "상행", myMetro: myMetro)
            })
            
            let downDirection = UIAlertAction(title: "하행", style: .default, handler: {(action:UIAlertAction) -> Void in
                for existingStation in metroStationList{
                    if existingStation.name == cellName && existingStation.line == cellLine && existingStation.direction == "하행"{
                        self.present(registeredStationError, animated: true, completion: nil)
                        return
                    }
                }
                
                var myMetro = MetroStation(name: cellName, line: cellLine, direction: "하행", trainList: [])
                metroStationList.append(myMetro)
                
                if let encoded = try? JSONEncoder().encode(metroStationList) {
                    UserDefaults.standard.set(encoded, forKey: "metroStationList")
                }
                getMetroStationData(keyword: cellName, line: cellLine, direction: "하행", myMetro: myMetro)
            })
            chooseDirection.addAction(upDirection)
            chooseDirection.addAction(downDirection)
        }
        
        let cancle = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        chooseDirection.addAction(cancle)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.present(chooseDirection, animated: true, completion: nil)
    }
    
}

extension MetroStationAdditionTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKeyword = searchController.searchBar.text else{
            return
        }
        filterContentForSearchKeyword(searchKeyword)
    }
}
