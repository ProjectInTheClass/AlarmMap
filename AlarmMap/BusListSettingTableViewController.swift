//
//  BusListSettingTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/04.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusListSettingTableViewController: UITableViewController {
    
    var busStop:BusStop? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBusList(arsId: busStop!.arsId!, myBusStop: busStop!, busListSettingTV: self.tableView)
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let addButton = sender as! UIButton
        addButton.isSelected = !addButton.isSelected
        
        let busListCell = addButton.superview?.superview?.superview as! BusListCell
        
        if(addButton.isSelected){
            busStop!.selectedBusList.append(busStop!.busList![busListCell.busIndex])
        }
        else{
            let busNumber = busStop!.busList![busListCell.busIndex].busNumber
            for (index,bus) in busStop!.selectedBusList.enumerated() {
                if(bus.busNumber == busNumber){
                    busStop!.selectedBusList.remove(at: index)
                    break
                }
            }
        }
        if let encoded = try? JSONEncoder().encode(busStopList) {
            UserDefaults.standard.set(encoded, forKey: "busStopList")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return busStop!.busList!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusListCell", for: indexPath) as! BusListCell
        
        cell.busNumberLabel.text = busStop!.busList![indexPath.row].busNumber
        
        cell.busIndex = indexPath.row
        cell.addButton.isSelected = false
        
        let busNumber = busStop!.busList![indexPath.row].busNumber
        for bus in busStop!.selectedBusList {
            if(bus.busNumber == busNumber){
                cell.addButton.isSelected = true
                break
            }
        }
        
        return cell
    }
    
}

