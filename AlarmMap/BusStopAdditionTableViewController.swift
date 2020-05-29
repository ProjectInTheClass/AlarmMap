//
//  BusStopAdditionTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/28.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import SwiftyXMLParser
import Alamofire

class BusStopAdditionTableViewController: UITableViewController {
    
    @IBOutlet var searchTextField: UITextField!
    
    //api 호출한 결과 여기다 저장
    //var searchResult = nil
    
    var temp:Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        temp = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(tempfun), userInfo: nil, repeats: true)
  
    }
    
    @objc func tempfun(){
        tableView.reloadData()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        var keyword = searchTextField.text
        //api 호출
        getStationData(stSrch: keyword!)
        //searchResult = ...
        
    }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopAdditionCell", for: indexPath) as! BusStopAdditionCell

        
        if(searchTextField.text == nil){
            searchTextField.placeholder = "역을 입력해주세요"
        }
        else{
            for busStops in busStopList{
                if let busStopName = busStops.name{
                    cell.busStopNameLabel.text = busStopName
                }
            }
        }
        

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
