//
//  RouteTableViewController.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/04/24.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class RouteListTableViewController: UITableViewController {
    
    let floatingAdditionButton = JJFloatingActionButton()
    
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let routineRouteInfoListData = UserDefaults.standard.data(forKey: "routineRouteInfoList"){
            if let routineRouteInfoListCodable = try? JSONDecoder().decode([RouteInfo.CodableRouteInfoStruct].self, from: routineRouteInfoListData){
                routeCategoryList[0].routeInfoList = routineRouteInfoListCodable.map({(codableRouteInfoStruct) -> RouteInfo in
                    return codableRouteInfoStruct.toRouteInfoClassInstance()
                })
            }
        }
        
        if let favoritesRouteInfoListData = UserDefaults.standard.data(forKey: "favoritesRouteInfoList"){
            if let favoritesRouteInfoListCodable = try? JSONDecoder().decode([RouteInfo.CodableRouteInfoStruct].self, from: favoritesRouteInfoListData){
                routeCategoryList[1].routeInfoList = favoritesRouteInfoListCodable.map({(codableRouteInfoStruct) -> RouteInfo in
                    return codableRouteInfoStruct.toRouteInfoClassInstance()
                })
            }
        }
        
        floatingAdditionButton.addItem(title: "", image: UIImage(systemName: "plus"), action: {item in self.routeAdditionButtonTapped(item)})
        floatingAdditionButton.display(inViewController: self)
        floatingAdditionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7).isActive = true
        floatingAdditionButton.buttonColor = UIColor(red: 22/255.0, green: 107/255.0, blue: 219/255.0, alpha: 0.7)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
        editButton.isEnabled = true
        var routeInfoCount = 0
        for routeCategory in routeCategoryList{
            routeInfoCount += routeCategory.routeInfoList.count
        }
        editButton.isEnabled = routeInfoCount == 0 ? false : true
    }
    
    @IBAction func routeAdditionButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "routeAdditionSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "routeSettingSegue") {
            let routeSettingTableViewController = segue.destination as! RouteSettingTableViewController
            
            let selectedCell = tableView.indexPathForSelectedRow
            
            routeSettingTableViewController.category =
                selectedCell!.section == 0 ? .routine : .favorites
            routeSettingTableViewController.routeInfoNumber = selectedCell!.row
            
            routeSettingTableViewController.isNewRouteInfo = false
            
            userSelectedStartingPoint = WayPoint(placeholder: 0)
            userSelectedDestinationPoint = WayPoint(placeholder: 1)
        }
        else if(segue.identifier == "routeAdditionSegue"){
            let routeSettingTableViewController = segue.destination as! RouteSettingTableViewController
            
            routeSettingTableViewController.isNewRouteInfo = true
            
            userSelectedStartingPoint = WayPoint(placeholder: 0)
            userSelectedDestinationPoint = WayPoint(placeholder: 1)
        }
        else{
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
            // by CSEDTD
            cell.routeSubtitleLabel.text = (routeCategoryList[indexPath.section].routeInfoList[indexPath.row].subtitle ?? " ")
            
            cell.routeAlarmSwitch.isOn = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].routeAlarmIsOn
            
            // by CSEDTD
            cell.routeInfo = routeCategoryList[indexPath.section].routeInfoList[indexPath.row]
            cell.routeInfoIndex = indexPath.row
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteListCell2", for: indexPath) as! RouteListCell2
            
            cell.routeTitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].title
            // by CSEDTD
            cell.routeSubtitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].subtitle ?? " "

            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return routeCategoryList[section].routeInfoList.count > 0 ? routeCategoryList[section].title : nil
    }
    
    @IBAction func RouteAlarmSwitchTapped(_ sender: Any) {
        let senderButton = sender as! UISwitch
        let cell = senderButton.superview?.superview?.superview as! RouteListCell1
        
        routeCategoryList[0].routeInfoList[cell.routeInfoIndex].routeAlarmIsOn = senderButton.isOn
        
        let RoutineRouteInfoListCodable = routeCategoryList[0].routeInfoList.map({(routeInfo) -> RouteInfo.CodableRouteInfoStruct in
            return routeInfo.toCodableStruct()
        })
        
        if let encoded = try? JSONEncoder().encode(RoutineRouteInfoListCodable) {
            UserDefaults.standard.set(encoded, forKey: "routineRouteInfoList")
        }
    }
}
