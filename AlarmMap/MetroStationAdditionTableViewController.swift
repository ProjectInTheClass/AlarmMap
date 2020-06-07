//
//  MetroStationAdditionTableViewController.swift
//  AlarmMap
//
//  Created by SeoungJun Oh on 2020/06/08.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class MetroStationAdditionTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate {

    var metroStationSearchBar:UISearchBar? = nil
    let metroStationSearchController = UISearchController()
    
    var candidates:Array<MetroPair> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        metroStationSearchBar = metroStationSearchController.searchBar
        metroStationSearchBar?.delegate = self
        metroStationSearchController.searchResultsUpdater=self
        metroStationSearchController.hidesNavigationBarDuringPresentation = false
        metroStationSearchController.obscuresBackgroundDuringPresentation = false
        metroStationSearchController.searchBar.placeholder = "지하철 입력"
        navigationItem.searchController = metroStationSearchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        candidates = metroStationCandidates
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func filterContentForSearchKeyword(_ searchKeyword: String) {
        if searchKeyword == ""{
            candidates = metroStationCandidates
        }
        else{
            var temp:Array < MetroPair > = []
            
            for metroPair in metroStationCandidates{
                if metroPair.name.contains(searchKeyword){
                    temp.append(metroPair)
                }
            }
            candidates = temp
        }
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return candidates.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetroStationAdditionCell", for: indexPath) as! MetroStationAdditionCell

        // Configure the cell...

        cell.lineLabel.text = candidates[indexPath.row].line
        cell.stationNameLabel.text = candidates[indexPath.row].name
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MetroStationAdditionTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKeyword = searchController.searchBar.text else{
            return
        }
        filterContentForSearchKeyword(searchKeyword)
    }
}
