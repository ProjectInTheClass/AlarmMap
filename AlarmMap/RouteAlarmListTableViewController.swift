//
//  RouteAlarmListTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteAlarmListTableViewController: UITableViewController {
    
    var routeInfo:RouteInfo? = nil

    @IBOutlet var addAlarmButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setToolbarHidden(false, animated: true)

        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "alarmSettingSegue"){
            let alarmSettingTableViewController = segue.destination as! AlarmSettingTableViewController
            
            alarmSettingTableViewController.routeInfo = routeInfo
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routeInfo!.routeAlarmList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteAlarmCell", for: indexPath) as! RouteAlarmCell
        
        let routeAlarm = routeInfo!.routeAlarmList[indexPath.row]
        
        cell.routeAlarmTimeLabel.text = routeAlarm.getTimeToString()
        cell.routeAlarmSubtitleLabel.text = "\(routeAlarm.aheadOf.toString()) / \(routeAlarm.getRepeatDatesToString())"
        cell.routeAlarmSwitch.isOn = routeAlarm.isOn
        
        // by CSEDTD
        cell.routeAlarm = routeAlarm
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            // by CSEDTD
            //routeInfo!.routeAlarmList.remove(at: indexPath.row)
            routeInfo!.removeAlarm(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }

}
