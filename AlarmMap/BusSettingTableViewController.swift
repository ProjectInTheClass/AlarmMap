//
//  BusSettingTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/24.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusSettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
//    @IBAction func backButtonTapped(_ sender: Any) {
//        performSegue(withIdentifier: "unwindBusList", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "unwindBusList"){
//        }
//    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return busStopList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusSettingCell", for: indexPath) as! BusSettingCell
        
        let busStop = busStopList[indexPath.row]
        
        if let busStopName = busStop.name{
            cell.busStopNameLabel.text = busStopName
        }
        
        var busStopArsId = ""
        var busStopDirection = ""
        if let tempBusStopArsId = busStop.arsId{
            busStopArsId = tempBusStopArsId
        }
        if let tempBusStopDirection = busStop.direction{
            busStopDirection = tempBusStopDirection + " 방면"
        }
        cell.busStopInfoLabel.text = "\(busStopArsId) | \(busStopDirection)"
        
        guard let myBusList = busStop.userSelectedBusList else{
            cell.busListLabel.text = ""
            return cell
        }
        
        cell.busListLabel.text = myBusList.reduce("", {(busList,bus) in
            return busList + "\(bus.busNumber) "
        })

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.isEditing = true
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.isEditing = false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            busStopList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let busStop = busStopList.remove(at: sourceIndexPath.row)
        busStopList.insert(busStop, at: destinationIndexPath.row)
    }

}
