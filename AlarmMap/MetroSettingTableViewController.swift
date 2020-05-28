//
//  MetroSettingTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/28.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import SwiftyXMLParser
import Alamofire

class MetroSettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getStationData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getURL(url:String, params:[String: Any]) -> URL {
        let urlParams = params.compactMap({ (key, value) -> String in
        return "\(value)"
        }).joined(separator: "/")
        let withURL = url + "/\(urlParams)"
        let encoded = withURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! //+ "&serviceKey=" + metroKey
        return URL(string:encoded)!
    }
    
    func getStationData() {
        let SeoulStationURL = "http://openapi.seoul.go.kr:8088"
        let url = getURL(url: SeoulStationURL, params: ["key": metroKey+"/xml/StationDayTrnsitNmpr/1/5/"])//["key": metroKey, "xml": "xml","serviceName":"StationDayTrnsitNmpr","startIndex":1,"endIndex":5])
        print(url)
        AF.request(url,method: .get).validate()
        .responseString { response in
        print(" - API url: \(String(describing: response.request!))")

        //if case success
        switch response.result {
            case .success(let value):
                    let responseString = NSString(data: response.data!, encoding:
                    String.Encoding.utf8.rawValue )
                    let xml = try! XML.parse(String(responseString!))
                    //self.myLabel.text=xml.text
                    print(responseString)
                    //var myBusStopList:[BusStop]=[]
                    /*for element in xml["ServiceResult"]["msgBody"]["itemList"] {
                        
                        /*if let arsId =
                            element["arsId"].text, let stNm = element["stNm"].text {
                            print("arsId = \(arsId)")
                            myBus.name = stNm
                            self.getStation(arsId: arsId,myBusStop : myBus)
                            //myBusStopList.append(myBusStop!)
                        }*/
                    }*/
                    //for bsl in myBusStopList{
                        //print(bsl)
            //}
            case .failure(let error):
                print(error)
            }
        }
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return metroStationList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MetroSettingCell", for: indexPath) as! MetroSettingCell

        cell.lineLabel.text = metroStationList[indexPath.row].line
        cell.stationNameLabel.text = metroStationList[indexPath.row].name
        cell.directionLabel.text = metroStationList[indexPath.row].direction

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            metroStationList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let metroStation = metroStationList.remove(at: sourceIndexPath.row)
        metroStationList.insert(metroStation, at: destinationIndexPath.row)
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
