//
//  BusFavoritesTableViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/23.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import JJFloatingActionButton
import SwiftyXMLParser
import Alamofire
class BusFavoritesTableViewController: UITableViewController {
    
    
    var busCellsOfBusStop:[[BusCell]] = []
    
    var busUpdateTimer:Timer? = nil
    
    var refreshCounter = 30
    
    let floatingRefreshButton = JJFloatingActionButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        floatingRefreshButton.addItem(title: "", image: UIImage(systemName: "arrow.clockwise"), action: {item in self.refresh()})
        floatingRefreshButton.display(inViewController: self)
        floatingRefreshButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7).isActive = true
        floatingRefreshButton.buttonColor = UIColor(red: 22/255.0, green: 107/255.0, blue: 219/255.0, alpha: 0.7)
        
        floatingRefreshButton.layer.zPosition = 1.0
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //getStationData(start_x: 126.890001872801, start_y: 37.5757542035555, end_x: 127.04249040816, end_y: 37.5804217059895)
    }
    
    /*func getURL(url:String, params:[String: Any]) -> URL {
        let urlParams = params.compactMap({ (key, value) -> String in
        return "\(key)=\(value)"
        }).joined(separator: "&")
        let withURL = url + "?\(urlParams)"
        let encoded = withURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&serviceKey=" + busKey
        return URL(string:encoded)!
    }
    
    func getStationData(start_x:Double, start_y:Double,end_x:Double,end_y:Double) {
        let SeoulStationURL = "http://ws.bus.go.kr/api/rest/pathinfo/getLocationInfo"
        let url = getURL(url: SeoulStationURL, params: ["startX": String(start_x),"startY":String(start_y),"endX":String(end_x),"endY":String(end_y)])
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
                        /*if let stNm = element["stNm"].text, let stId = element["stId"].text, let arsId =
                            element["arsId"].text {
                            print("stNm = \(stNm), stId = \(stId), arsId = \(arsId)")
                        }*/
                        var myBus=BusStop(name: nil, direction: nil, busList: nil)
                        busStopList.append(myBus)
                        if let arsId =
                            element["arsId"].text, let stNm = element["stNm"].text {
                            print("arsId = \(arsId)")
                            myBus.name = stNm
                            self.getStation(arsId: arsId,myBusStop : myBus)
                            //myBusStopList.append(myBusStop!)
                        }
                    }*/
                    //for bsl in myBusStopList{
                        //print(bsl)
            //}
            case .failure(let error):
                print(error)
            }
        }
    }*/
    
    @objc func busUpdate(){
        //var bus:Bus
        var busCell:BusCell
        
        for busStopIndex in 0..<busCellsOfBusStop.count {
            
            for busCellIndex in 0..<busCellsOfBusStop[busStopIndex].count {
                guard let bus = busStopList[busStopIndex].busList else{
                    break
                }
                
                bus[busCellIndex].decreaseRemainingTime()
                
                busCell = busCellsOfBusStop[busStopIndex][busCellIndex]
                guard let firstTimeLabel=busCell.firstBusRemainingTimeLabel else{
                    continue
                }
                guard let secondTimeLabel=busCell.secondBusRemainingTimeLabel else{
                    continue
                }
                
                firstTimeLabel.text = bus[busCellIndex].firstBusRemainingTime
                secondTimeLabel.text = bus[busCellIndex].secondBusRemainingTime
            }
        }
        /*for busStopIndex in 0..<busStopList.count{
            print(busStopList.count)
            guard let buslist=busStopList[busStopIndex].busList else{
                continue
            }
            for busCellIndex in 0..<buslist.count{
                print(String(buslist.count))
                print(buslist[busCellIndex].firstBusRemainingTime)
                buslist[busCellIndex].decreaseRemainingTime()
                print(buslist[busCellIndex].firstBusRemainingTime)
            }
        }*/
        
        refreshCounter -= 1
        
        if(refreshCounter <= 0){
            //call refresh function
            refreshCounter = 30
        }
    }
    
    func refresh(){
        print("refresh")
        for busStop in busStopList{
            guard let stationId = busStop.arsId else{
                continue
            }
            refreshStation(arsId: stationId, myBusStop: busStop)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "busSettingSegue"){
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        for _ in 0..<busStopList.count{
            busCellsOfBusStop.append([BusCell]())
        }
        
        tableView.reloadData()
        busUpdateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(busUpdate), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        busUpdateTimer?.invalidate()
        busCellsOfBusStop = []
    }
    
//    @IBAction func unwindBusList(segue:UIStoryboardSegue) {
//        tableView.reloadData()
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return busStopList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let ret=busStopList[section].busList else{
            return 1
        }
        for _ in 0..<ret.count{
            //var myBusCell=BusCell()
            busCellsOfBusStop[section].append(BusCell())
        }
        return ret.count + 1
        //bus stop cell + bus cells
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){ //bus stop cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopCell", for: indexPath) as! BusStopCell
            
            cell.busStopNameLabel.text = busStopList[indexPath.section].name
            cell.busStopDirectionLabel.text = busStopList[indexPath.section].direction
            
            return cell
        }
        else{ //bus cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusCell", for: indexPath) as! BusCell
            
            guard let myBusList=busStopList[indexPath.section].busList else{
                return cell
            }
            let bus = myBusList[indexPath.row - 1]
            
            cell.busNumberLabel.text = bus.busNumber
            
            cell.firstBusRemainingTimeLabel.text = bus.firstBusRemainingTime
            cell.firstBusCurrentLocationLabel.text = bus.firstBusCurrentLocation
            
            cell.secondBusRemainingTimeLabel.text = bus.secondBusRemainingTime
            cell.secondBusCurrentLocationLabel.text = bus.secondBusCurrentLocation
            
            
            busCellsOfBusStop[indexPath.section][indexPath.row - 1] = cell
            
            return cell
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == busStopList.count - 1){
            return 30
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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
