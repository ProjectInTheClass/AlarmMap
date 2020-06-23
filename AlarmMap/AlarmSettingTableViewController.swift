//
//  AlarmSettingTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class AlarmSettingTableViewController: UITableViewController {

    @IBOutlet var alarmTimeDatePicker: UIDatePicker!
    
    @IBOutlet var sunButton: UIButton!
    
    @IBOutlet var monButton: UIButton!
    
    @IBOutlet var tueButton: UIButton!
    
    @IBOutlet var wedButton: UIButton!
    
    @IBOutlet var thuButton: UIButton!
    
    @IBOutlet var friButton: UIButton!
    
    @IBOutlet var satButton: UIButton!
    
    @IBOutlet var aheadOfTimeSegmtdCtrll: UISegmentedControl!
    
    var dateButtonList = [UIButton]()
    
    var routeInfo:RouteInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        dateButtonList = [sunButton, monButton,tueButton,wedButton,thuButton,friButton,satButton]

        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    @IBAction func dateButtonTapped(_ sender: Any) {
        var senderDateButton = sender as! UIButton
        senderDateButton.isSelected = !(senderDateButton.isSelected)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        // by CSEDTD
        var aheadOf: AheadOfTime
        var repeatDates = [Bool]()
        switch aheadOfTimeSegmtdCtrll.selectedSegmentIndex {
        case 0:
            aheadOf = .none
        case 1:
            aheadOf = .five
        case 2:
            aheadOf = .fifteen
        case 3:
            aheadOf = .thirty
        default:
            aheadOf = .none
        }
        
        for index in 0...6{
            repeatDates.append(dateButtonList[index].isSelected)
        }
        
        let additionalSecond: Int = Calendar(identifier: .iso8601).dateComponents([.second], from: alarmTimeDatePicker.date).second!

        // 0611
        let newRouteAlarm = RouteAlarm(time: alarmTimeDatePicker.date - Double(additionalSecond), repeatDates: repeatDates, aheadOf: aheadOf, route: routeInfo!.route, repeats: true, infoIsOn: routeInfo!.routeAlarmIsOn, routeTitle: routeInfo!.title, routeSubtitle: routeInfo!.subtitle, routeTotalDisplacement: routeInfo!.totalDisplacement, routeTotalTime: routeInfo!.totalTime)
        
        routeInfo!.routeAlarmList.append(newRouteAlarm)

        self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
}
