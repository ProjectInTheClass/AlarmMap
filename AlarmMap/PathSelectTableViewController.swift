//
//  PathSelectTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/23.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class PathSelectTableViewController: UITableViewController {

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
        return routeCategoryList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return routeCategoryList[section].routeInfoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteListCell1", for: indexPath) as! RouteListCell1
            
            cell.routeTitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].title
            cell.routeSubtitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].subtitle
            
            cell.routeAlarmSwitch.isEnabled = false
            cell.routeAlarmSwitch.alpha = 0
            
            // by CSEDTD
            cell.routeInfo = routeCategoryList[indexPath.section].routeInfoList[indexPath.row]
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteListCell2", for: indexPath) as! RouteListCell2
            
            cell.routeTitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].title
            cell.routeSubtitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].subtitle
            
            cell.routeInfo = routeCategoryList[indexPath.section].routeInfoList[indexPath.row]
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var routeInfo = RouteInfo()
        if(indexPath.section == 0){ //RouteListCell1
            let selectedCell = tableView.cellForRow(at: indexPath) as! RouteListCell1
            routeInfo = selectedCell.routeInfo!
        }
        else{
            let selectedCell = tableView.cellForRow(at: indexPath) as! RouteListCell2
            routeInfo = selectedCell.routeInfo!
        }
        
        let pathFindingAlarm = RouteAlarm(time: Date(), repeatDates: [true, true, true, true, true, true, true], aheadOf: .none, route: routeInfo.route, repeats: false, infoIsOn: true, routeTitle: routeInfo.title, routeSubtitle: routeInfo.subtitle, routeTotalDisplacement: routeInfo.totalDisplacement, routeTotalTime: routeInfo.totalTime)
        if workingAlarmExists == true {
            // TODO - modal 띄워서 지금 실행 중인 경로 무시할 거냐고 물어봐야 함. 지금은 급하니까 생략
        }
        pathFindingAlarm.alarmStarts()
        pathFindingAlarm.startTimer.invalidate()
        /*
        workingAlarm.routeTitle = routeInfo.title
        workingAlarm.routeSubtitle = routeInfo.subtitle
        workingAlarm.routeTotalTime = routeInfo.totalTime
        workingAlarm.routeTotalDisplacement = routeInfo.totalDisplacement
        workingAlarm.route = routeInfo.route
        /*경로 탐색 시작*/

        workingAlarm.infoIsOn = true
        workingAlarm.isOn = true
        workingAlarm.alarmStarts()
         */
        self.navigationController?.popViewController(animated: true)
    }

}
