//
//  MetroFavoritesTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/23.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class MetroFavoritesTableViewController: UITableViewController {
    
    var metroUpdateTimer:Timer? = nil
    
    var refreshCounter = 20
    
    let floatingRefreshButton = JJFloatingActionButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let metroStationListData = UserDefaults.standard.data(forKey: "metroStationList"){
            if let tempMetroStationList = try? JSONDecoder().decode([MetroStation].self, from: metroStationListData){
                metroStationList = tempMetroStationList
            }
        }
        
        floatingRefreshButton.addItem(title: "", image: UIImage(systemName: "arrow.clockwise"), action: {item in self.refresh()})
        floatingRefreshButton.display(inViewController: self)
        floatingRefreshButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7).isActive = true
        floatingRefreshButton.buttonColor = UIColor(red: 22/255.0, green: 107/255.0, blue: 219/255.0, alpha: 0.7)
        
        floatingRefreshButton.layer.zPosition = 1.0
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
        tableView.reloadData()
        metroUpdateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(metroUpdate), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        metroUpdateTimer?.invalidate()
    }
    @objc func metroUpdate(){
        
        tableView.reloadData()
        refreshCounter -= 1
        
        if(refreshCounter <= 0){
            refresh()
            refreshCounter = 20
        }
    }
    
    func refresh(){
        for station in metroStationList{
            station.trainList = []
            getMetroStationData(keyword: station.name, line: station.line, direction: station.direction, myMetro: station)
        }
        //getMetroStationData(keyword: cellName, line: cellLine, direction: "내선", myMetro: myMetro)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return metroStationList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "MetroStationCell", for: indexPath) as! MetroStationCell
            
            let metroStation = metroStationList[indexPath.section]
            
            cell.lineLabel.text = metroStation.line
            cell.lineLabel.backgroundColor = lineColor(line: metroStation.line)
            cell.StationNameLabel.text = metroStation.name
            cell.directionLabel.text = metroStation.direction
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrainsCell", for: indexPath) as! TrainsCell
            
            let trainList = metroStationList[indexPath.section].trainList
            if trainList.count >= 1{
                cell.firstTrainRemainingTimeLabel.text = trainList[0].timeRemaining
                cell.firstTrainCurrentStationLabel.text = trainList[0].currentStation
                cell.firstTrainTerminalStationLabel.text = trainList[0].terminalStation
            }
            
            if trainList.count >= 2{
                cell.secondTrainRemainingTimeLabel.text = trainList[1].timeRemaining
                cell.secondTrainCurrentStationLabel.text = trainList[1].currentStation
                cell.secondTrainTerminalStationLabel.text = trainList[1].terminalStation
            }
            
            let metroStation = metroStationList[indexPath.section]
            cell.firstTrainView.backgroundColor = lineColor(line: metroStation.line)
            cell.secondTrainView.backgroundColor = lineColor(line: metroStation.line)
            
            return cell
        }
    }

}
