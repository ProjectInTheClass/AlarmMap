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
class BusFavoritesTableViewController: UITableViewController, UISearchBarDelegate {
    
    var busCellsOfBusStop:[[BusCell]] = []
    
    var busUpdateTimer:Timer? = nil
    
    var refreshCounter = 20
    
    let floatingRefreshButton = JJFloatingActionButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        floatingRefreshButton.addItem(title: "", image: UIImage(systemName: "arrow.clockwise"), action: {item in self.refresh()})
        floatingRefreshButton.display(inViewController: self)
        floatingRefreshButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7).isActive = true
        floatingRefreshButton.buttonColor = UIColor(red: 22/255.0, green: 107/255.0, blue: 219/255.0, alpha: 0.7)
        
        floatingRefreshButton.layer.zPosition = 1.0
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.view.backgroundColor = UIColor.systemGray5
        let footerView = UIView(frame: .init(x: 0, y: 0, width: self.view.frame.width, height: 90))
        footerView.backgroundColor = UIColor.systemGray5
        self.tableView.tableFooterView = footerView
        
       // definesPresentationContext = true
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
        
        /*for busStopIndex in 0..<busCellsOfBusStop.count {
            
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
        }*/
        for busStopIndex in 0..<busStopList.count{
            print(busStopList.count)
            guard let buslist=busStopList[busStopIndex].userSelectedBusList else{
                continue
            }
            for busCellIndex in 0..<buslist.count{
                print(String(buslist.count))
                print(buslist[busCellIndex].firstBusRemainingTime)
                buslist[busCellIndex].decreaseRemainingTime()
                print(buslist[busCellIndex].firstBusRemainingTime)
            }
        }
        tableView.reloadData()
        refreshCounter -= 1
        
        if(refreshCounter <= 0){
            refresh()
            refreshCounter = 20
        }
    }
    
    func refresh(){
        print("refresh")
        for busStop in busStopList{
            guard let stationId = busStop.arsId else{
                continue
            }
            refreshBusStation(arsId: stationId, myBusStop: busStop, busFavoritesTV:self.tableView)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "busListSettingSegue"){
            let busListSettingVC = segue.destination as! BusListSettingViewController
            
            let busListButton = sender as! UIButton
            let busStopCell = busListButton.superview?.superview?.superview as! BusStopCell
            
            busListSettingVC.busStop = busStopList[busStopCell.busStopIndex]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        /*for _ in 0..<busStopList.count{
            busCellsOfBusStop.append([BusCell]())
        }*/
        tableView.reloadData()
        refresh()
        busUpdateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(busUpdate), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        busUpdateTimer?.invalidate()
        busCellsOfBusStop = []
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return busStopList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let ret=busStopList[section].userSelectedBusList else{
            return 1
        }
        /*for _ in 0..<ret.count{
            //var myBusCell=BusCell()
            busCellsOfBusStop[section].append(BusCell())
        }*/
        return ret.count + 1
        //bus stop cell + bus cells
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){ //bus stop cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopCell", for: indexPath) as! BusStopCell
            
            if let busStopName = busStopList[indexPath.section].name{
                cell.busStopNameLabel.text = busStopName
            }
            
            cell.busStopDirectionLabel.text = ""
            if let busStopDirection = busStopList[indexPath.section].direction {
                cell.busStopDirectionLabel.text = busStopDirection + " 방면"
            }
            
            cell.busStopIndex = indexPath.section
            
            return cell
        }
        else{ //bus cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusCell", for: indexPath) as! BusCell
            
            guard let myBusList=busStopList[indexPath.section].userSelectedBusList else{
                return cell
            }
            let bus = myBusList[indexPath.row - 1]
            
            cell.busNumberLabel.text = bus.busNumber
            
            cell.firstBusRemainingTimeLabel.text = bus.firstBusRemainingTime
            cell.firstBusCurrentLocationLabel.text = bus.firstBusCurrentLocation
            
            cell.secondBusRemainingTimeLabel.text = bus.secondBusRemainingTime
            cell.secondBusCurrentLocationLabel.text = bus.secondBusCurrentLocation
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
}
