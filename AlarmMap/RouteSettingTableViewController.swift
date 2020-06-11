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
    
    //section
    var category:RouteCategoryEnum = .favorites
    var changedCategory:RouteCategoryEnum = .favorites
    //row
    var routeInfoNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeTitleTextField.delegate = self
        routeSubtitleTextField.delegate = self
            
        scheduledDateFormatter.locale = Locale(identifier: "ko")
        scheduledDateFormatter.dateStyle = .long
        scheduledDateFormatter.timeStyle = .short
        
        if(isNewRouteInfo){
            myRouteInfo = RouteInfo() //new Route Info

            scheduledDateLabel.text = ""
            
            doneButton.isEnabled = false
        }
        
        else {
            myRouteInfo = routeCategoryList[category.toInt()].routeInfoList[routeInfoNumber]
            
            routeTitleTextField.text = myRouteInfo!.title
            routeSubtitleTextField.text = myRouteInfo!.subtitle
            
            // by CSEDTD - toString method added
            // TODO - error will arise maybe...
            startingPointLabel.text = myRouteInfo!.routes.first!.startingPoint.toString()
            destinationLabel.text = myRouteInfo!.routes.last!.destinationPoint.toString()
            
            scheduledDatePicker.date = myRouteInfo!.scheduledDate
            scheduledDateLabel.text = scheduledDateFormatter.string(from: myRouteInfo!.scheduledDate)
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 50))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "routeAlarmListSegue"){
            let routeAlarmListTableViewController = segue.destination as! RouteAlarmListTableViewController
            
            routeAlarmListTableViewController.routeInfo = myRouteInfo
        }
        // by CSEDTD
        else if (segue.identifier == "routeSearchSegue") {
            let routeSearchingVC = segue.destination as! RouteSearchingParentsViewController
            routeSearchingVC.myRouteInfo = myRouteInfo
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        myRouteInfo!.title = routeTitleTextField.text!
        myRouteInfo!.subtitle = routeSubtitleTextField.text!
        
        myRouteInfo!.scheduledDate = scheduledDatePicker.date
        
        changedCategory = myRouteInfo!.routeAlarmList.isEmpty ? .favorites : .routine
        
        if(isNewRouteInfo){
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
    }
    
    //disable or enable save button
    @IBAction func routeTitleTextFieldChanged(_ sender: Any) {
        if(routeTitleTextField.text == ""){
            doneButton.isEnabled = false
        }
        else {
            doneButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
