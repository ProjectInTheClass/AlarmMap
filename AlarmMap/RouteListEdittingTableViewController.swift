//
//  RouteListEdittingTableViewController.swift
//  
//
//  Created by SeoungJun Oh on 2020/07/19.
//

import UIKit

class RouteListEdittingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.isEditing = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tableView.isEditing = false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteListCell2", for: indexPath) as! RouteListCell2
        
        cell.routeTitleLabel.text = routeCategoryList[indexPath.section].routeInfoList[indexPath.row].title
        // by CSEDTD
        cell.routeSubtitleLabel.text = (routeCategoryList[indexPath.section].routeInfoList[indexPath.row].subtitle ?? " ")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return routeCategoryList[section].routeInfoList.count > 0 ? routeCategoryList[section].title : nil
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            routeCategoryList[indexPath.section].routeInfoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            let RouteInfoListCodable = routeCategoryList[indexPath.section].routeInfoList.map({(routeInfo) -> RouteInfo.CodableRouteInfoStruct in
                return routeInfo.toCodableStruct()
            })
            
            if let encoded = try? JSONEncoder().encode(RouteInfoListCodable) {
                if(indexPath.section == 0){
                    UserDefaults.standard.set(encoded, forKey: "routineRouteInfoList")
                }
                else{
                    UserDefaults.standard.set(encoded, forKey: "favoritesRouteInfoList")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let routeInfo = routeCategoryList[sourceIndexPath.section].routeInfoList.remove(at: sourceIndexPath.row)
        routeCategoryList[destinationIndexPath.section].routeInfoList.insert(routeInfo, at: destinationIndexPath.row)
        
        if(sourceIndexPath.section != destinationIndexPath.section){
            let routeInfo = routeCategoryList[destinationIndexPath.section].routeInfoList.remove(at: destinationIndexPath.row)
            routeCategoryList[sourceIndexPath.section].routeInfoList.insert(routeInfo, at: sourceIndexPath.row)
            
            tableView.reloadData()
        }
        else{
            
            let RouteInfoListCodable = routeCategoryList[destinationIndexPath.section].routeInfoList.map({(routeInfo) -> RouteInfo.CodableRouteInfoStruct in
                return routeInfo.toCodableStruct()
            })
            
            if let encoded = try? JSONEncoder().encode(RouteInfoListCodable) {
                if(destinationIndexPath.section == 0){
                    UserDefaults.standard.set(encoded, forKey: "routineRouteInfoList")
                }
                else{
                    UserDefaults.standard.set(encoded, forKey: "favoritesRouteInfoList")
                }
            }
        }
    }
    
}
