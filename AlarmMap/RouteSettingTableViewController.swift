//
//  RouteSettingTableViewController.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/05/01.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit

class RouteSettingTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var routeTitleTextField: UITextField!
    
    @IBOutlet var routeSubtitleTextField: UITextField!
    
    @IBOutlet var startingPointLabel: UILabel!
    
    @IBOutlet var destinationLabel: UILabel!
    
    @IBOutlet var scheduledDateLabel: UILabel!
    
    @IBOutlet var scheduledDatePicker: UIDatePicker!
    
    var isNewRouteInfo = true //true: route addtion. false: setting route alreay exists
    
    var defaultCellHeight:CGFloat = 0.0

    let scheduledDateFormatter = DateFormatter()
    
    var myRouteInfo: RouteInfo? = nil
    var tempRouteInfo: RouteInfo = RouteInfo()
    
    //section
    var category:RouteCategoryEnum = .favorites
    var changedCategory:RouteCategoryEnum = .favorites
    //row
    var routeInfoNumber = 0
    
    // 0623
    var routeTitleTextFieldFilled: Bool = true
    var routeSelected: Bool = false
    var routeChanged: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeTitleTextField.delegate = self
        routeSubtitleTextField.delegate = self
            
        scheduledDateFormatter.locale = Locale(identifier: "ko")
        scheduledDateFormatter.dateStyle = .long
        scheduledDateFormatter.timeStyle = .short
        
        tempRouteInfo = RouteInfo()
        
        // 0623
        routeChanged = false
        
        if(isNewRouteInfo){
            myRouteInfo = RouteInfo() //new Route Info
            
            scheduledDateLabel.text = ""
            
            // 0623
            routeTitleTextFieldFilled = false
            routeSelected = false
            
            doneButton.isEnabled = false
        }
        
        else {
            myRouteInfo = routeCategoryList[category.toInt()].routeInfoList[routeInfoNumber]
            
            scheduledDatePicker.date = myRouteInfo!.scheduledDate
            scheduledDateLabel.text = scheduledDateFormatter.string(from: myRouteInfo!.scheduledDate)
            
            tempRouteInfo.startingPoint = myRouteInfo!.startingPoint
            tempRouteInfo.destinationPoint = myRouteInfo!.destinationPoint
            
            // 0623
            routeTitleTextFieldFilled = true
            routeSelected = true
        }
        
        routeTitleTextField.text = myRouteInfo!.title
        routeSubtitleTextField.text = myRouteInfo!.subtitle
        startingPointLabel.text = myRouteInfo!.startingPoint.location.name
        destinationLabel.text = myRouteInfo!.destinationPoint.location.name
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 50))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.view.endEditing(true)
        if(segue.identifier == "routeAlarmListSegue"){
            let routeAlarmListTableViewController = segue.destination as! RouteAlarmListTableViewController
            
            tableView.deselectRow(at: IndexPath(row: 0, section: 2), animated: true)
            routeAlarmListTableViewController.routeInfo = myRouteInfo
        }
        else if (segue.identifier == "routeSearchSegue") {
            let routeSearchingVC = segue.destination as! RouteSearchingParentsViewController
            tableView.deselectRow(at: IndexPath(row: 0, section: 1), animated: true)
            //routeSearchingVC.startingPoint = tempRouteInfo.startingPoint
            //routeSearchingVC.destinationPoint = tempRouteInfo.destinationPoint
            userSelectedStartingPoint = tempRouteInfo.startingPoint
            userSelectedDestinationPoint = tempRouteInfo.destinationPoint
            
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        myRouteInfo!.title = routeTitleTextField.text!
        myRouteInfo!.subtitle = routeSubtitleTextField.text!
        
        myRouteInfo!.scheduledDate = scheduledDatePicker.date
        
        // 0623
        //TODO - myRouteInfo!.route와 다른 field 처리
        if routeChanged == true {
            myRouteInfo!.route = tempRouteInfo.route
            myRouteInfo!.totalDisplacement = tempRouteInfo.totalDisplacement
            myRouteInfo!.totalTime = tempRouteInfo.totalTime
        }
        for alarm in myRouteInfo!.routeAlarmList {
            alarm.finished()
            
            if routeChanged == true {
                //TODO - myRouteInfo!.route와 다른 field 처리
                alarm.route = myRouteInfo!.route
                alarm.routeTotalDisplacement = myRouteInfo!.totalDisplacement
                alarm.routeTotalTime = myRouteInfo!.totalTime
            }
            alarm.routeTitle = myRouteInfo!.title
            alarm.routeSubtitle = myRouteInfo!.subtitle
        }
        // 0623 TODO - 아마도 여기 코드를 위의 if 안에 넣어야 할 듯 (routeChanged)
        myRouteInfo!.startingPoint = tempRouteInfo.startingPoint
        myRouteInfo!.destinationPoint = tempRouteInfo.destinationPoint
        myRouteInfo!.totalCost = tempRouteInfo.totalCost
        myRouteInfo!.totalTime = tempRouteInfo.totalTime
        myRouteInfo!.totalDisplacement = tempRouteInfo.totalDisplacement
        myRouteInfo!.transferCount = tempRouteInfo.transferCount
        
        changedCategory = myRouteInfo!.routeAlarmList.isEmpty ? .favorites : .routine
                
        if(isNewRouteInfo){
            myRouteInfo!.routeAlarmIsOn = true
            for alarm in myRouteInfo!.routeAlarmList {
                alarm.infoIsOn = true
            }
            //append to list
            routeCategoryList[changedCategory.toInt()].routeInfoList.append(myRouteInfo!)
        }
        else if (category != changedCategory){
            routeCategoryList[changedCategory.toInt()].routeInfoList.append( routeCategoryList[category.toInt()].routeInfoList.remove(at: routeInfoNumber))
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func scheduledDatePickerValueChanged(_ sender: Any) {
        scheduledDateLabel.text = scheduledDateFormatter.string(from: scheduledDatePicker.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
        startingPointLabel.text = tempRouteInfo.startingPoint.location.name
        destinationLabel.text = tempRouteInfo.destinationPoint.location.name
        
        doneButton.isEnabled = routeTitleTextFieldFilled && routeSelected
    }
    
    //disable or enable save button
    // 0623
    @IBAction func routeTitleTextFieldChanged(_ sender: Any) {
        if(routeTitleTextField.text == ""){
            // by CSEDTD
            routeTitleTextFieldFilled = false
            doneButton.isEnabled = false
        }
        else {
            // by CSEDTD
            routeTitleTextFieldFilled = true
            if routeSelected == true {
                doneButton.isEnabled = true
            }
            else {
                doneButton.isEnabled = false
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func unwindRouteSettingTVC (segue : UIStoryboardSegue) {
    
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 1
        case 3:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 2 && indexPath.row == 2){
            return 160
        }
        else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }

}
