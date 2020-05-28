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

    func getURL(url:String, params:[String: Any]) -> URL {
        let urlParams = params.compactMap({ (key, value) -> String in
        return "\(key)=\(value)"
        }).joined(separator: "&")
        let withURL = url + "?\(urlParams)"
        let encoded = withURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&serviceKey=" + busKey
        return URL(string:encoded)!
    }
    
    func getStationData(stSrch: String) {
        let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByName"
        let url = getURL(url: SeoulStationURL, params: ["stSrch": stSrch])
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
                    //print(responseString)
                    //var myBusStopList:[BusStop]=[]
                    for element in xml["ServiceResult"]["msgBody"]["itemList"] {
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
                    }
                    //for bsl in myBusStopList{
                        //print(bsl)
            //}
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getStation(arsId: String, myBusStop:BusStop) {
        let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid"
        let url = getURL(url: SeoulStationURL, params: ["arsId": arsId])
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
                    //print(responseString)
                    var myBusList:[Bus]=[]
                    for element in xml["ServiceResult"]["msgBody"]["itemList"] {
                        if let arrmsg1 = element["arrmsg1"].text, let arrmsg2 = element["arrmsg2"].text, let rtNm =
                            element["rtNm"].text, let adirection = element["adirection"].text, let nxtStn = element["nxtStn"].text {
                            print("stNm = \(arrmsg1), stId = \(arrmsg2), arsId = \(arsId), rtNm = \(rtNm), adirection = \(adirection)")
                            
                            var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                            //var myBus=Bus(busNumber: rtNm, firstBusRemainingTime: arrmsg1, firstBusCurrentLocation: nil, secondBusRemainingTime: arrmsg2, secondBusCurrentLocation: nil)
                            myBusList.append(myBus)
                            myBusStop.direction = adirection
                        }
                    
                    }
                    myBusStop.busList=myBusList
                    for bsl in busStopList{
                        print("mybsl")
                    }
                    //myBusStop = BusStop(name: mystNm!, direction: myadirection!, busList: myBusList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
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
