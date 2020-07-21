//
//  PathFindingParentsViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/23.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import JJFloatingActionButton

class PathFindingParentsViewController: UIViewController {
    
    @IBOutlet var routeTitleLabel: UILabel!
    
    @IBOutlet var routeSubtitleLabel: UILabel!
    
    @IBOutlet var currentLocationProgView: UIProgressView!
    
    @IBOutlet var routeRemainingTimeLabel: UILabel!
    
    var pathFindingTV:UITableView? = nil
    
    var viewUpdateTimer:Timer? = nil
    var refreshCounter = 0
    
    let floatingRefreshButton = JJFloatingActionButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray4
        
        currentLocationProgView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        
        floatingRefreshButton.addItem(title: "", image: UIImage(systemName: "arrow.clockwise"), action: {item in self.refresh()})
        floatingRefreshButton.display(inViewController: self)
        floatingRefreshButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7).isActive = true
        floatingRefreshButton.buttonColor = UIColor(red: 22/255.0, green: 107/255.0, blue: 219/255.0, alpha: 0.7)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //workingAlarm.pathFindingTV = self.pathFindingTV
        
        pathInfoUpdate()
        refresh()
        
        viewUpdateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(viewUpdate), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewUpdateTimer?.invalidate()
    }
    
    @objc func viewUpdate(){
        pathInfoUpdate()
        
        if(workingAlarm.routeIndex >= 0){
            refreshCounter -= 1
            if(workingAlarm.routeIndex == 0){
                busCellUpdate(routeIndex: workingAlarm.routeIndex+1)
            }
            else{
                busCellUpdate(routeIndex: workingAlarm.routeIndex-1)
                busCellUpdate(routeIndex: workingAlarm.routeIndex)
            }
        }
        
        if(refreshCounter < 0){
            refreshCounter = 15
            refresh()
        }
    }
    
    func pathInfoUpdate(){
        if(workingAlarm.routeIndex < 0){
            routeTitleLabel.text = ""
            routeSubtitleLabel.text = ""
            currentLocationProgView.progress = 0
            routeRemainingTimeLabel.text = ""
            pathFindingTV?.reloadData()
            return
        }

        pathFindingTV?.reloadData()
        
        routeTitleLabel.text = workingAlarm.routeTitle
        routeSubtitleLabel.text = workingAlarm.routeSubtitle
        
        var remainingTime = 0
        //var distToNextWaypointPropotion:Double = 0
        print("------------------------------------------------")
        print(currentDistance)
        print("------------------------------------------------")
//        distToNextWaypointPropotion = currentDistance / workingAlarm.route[workingAlarm.routeIndex].distance
//        remainingTime = Int(round((Double(workingAlarm.route[workingAlarm.routeIndex].takenSeconds)/60.0 * distToNextWaypointPropotion)))
        
        // by CSEDTD routeIndex --> routeIndex-1, routeIndex+1 --> routeIndex
        if workingAlarm.routeIndex-1 == workingAlarm.route.count-1 {
            routeRemainingTimeLabel.text = "도착했습니다."
        } else if workingAlarm.routeIndex == 0 {
            for index in (workingAlarm.routeIndex)...(workingAlarm.route.count-1) {
                remainingTime += Int(round(Double(workingAlarm.route[index].takenSeconds)/60.0))
            }
        } else {
            for index in (workingAlarm.routeIndex-1)...(workingAlarm.route.count-1){
                remainingTime += Int(round(Double(workingAlarm.route[index].takenSeconds)/60.0))
            }
            
            routeRemainingTimeLabel.text = "약 \(remainingTime)분 후 도착 예정입니다."
        }
        
        currentLocationProgView.progress = 1.0 - Float(remainingTime) /  Float(workingAlarm.routeTotalTime)
    }
    
    func refresh(){
        if(workingAlarm.routeIndex < 0){
            return
        }
        
        if(workingAlarm.routeIndex == 0){
            waypointNodeUpdate(routeIndex: workingAlarm.routeIndex+1)
        }
        else{
            waypointNodeUpdate(routeIndex: workingAlarm.routeIndex-1)
            waypointNodeUpdate(routeIndex: workingAlarm.routeIndex)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "PathFindingTVCEmbedSegue"){
            let pathFindingTVC = segue.destination as! PathFindingTableViewController
            
            pathFindingTV = pathFindingTVC.tableView
        }
    }

    @IBAction func settingButtonTapped(_ sender: Any) {
        let settingPathFinding = UIAlertController(title: "설정", message: "", preferredStyle: .actionSheet)
        
        let startPathFinding = UIAlertAction(title: "이동 시작", style: .default, handler: {(action:UIAlertAction) -> Void in
            self.performSegue(withIdentifier: "PathSelectSegue", sender: nil)
        })
        
        let stopPathFinding = UIAlertAction(title: "이동 중단", style: .default, handler: {(action:UIAlertAction) -> Void in
            /*경로 탐색 중단*/
            workingAlarm.finished()
            self.pathInfoUpdate()
            self.pathFindingTV!.reloadData()
        })
        
        settingPathFinding.addAction(startPathFinding)
        settingPathFinding.addAction(stopPathFinding)
        
        let cancle = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        settingPathFinding.addAction(cancle)
               
        self.present(settingPathFinding, animated: true, completion: nil)
    }
    
    func waypointNodeUpdate(routeIndex:Int){
        let waypoint = workingAlarm.route[routeIndex]
        
        switch waypoint.type{
        case .bus:
            if(waypoint.onboarding){
                let busStop = waypoint.node as! BusStop
                
                refreshBusStation(arsId: busStop.arsId!, myBusStop: busStop, busFavoritesTV: pathFindingTV!)
                
                workingAlarm.route[routeIndex].node = busStop
            }
        case .metro:
            if(waypoint.onboarding){
                let metroStation = waypoint.node as! MetroStation
                
                var metroStation0: MetroStation
                var metroStation1: MetroStation
                
                
                if(metroStation.line == "2호선"){
                    metroStation0 = MetroStation(name: metroStation.name, line: metroStation.line, direction: "내선", trainList: [])
                    metroStation1 = MetroStation(name: metroStation.name, line: metroStation.line, direction: "외선", trainList: [])
                }
                else{
                    metroStation0 = MetroStation(name: metroStation.name, line: metroStation.line, direction: "상행", trainList: [])
                    metroStation1 = MetroStation(name: metroStation.name, line: metroStation.line, direction: "하행", trainList: [])
                }
                
                getMetroStationData(keyword: metroStation0.name, line: metroStation0.line, direction: metroStation0.direction, myMetro: metroStation0)
                getMetroStationData(keyword: metroStation1.name, line: metroStation1.line, direction: metroStation1.direction, myMetro: metroStation1)
                
                pathFindingMetroStations[0] = metroStation0
                pathFindingMetroStations[1] = metroStation1
                //workingAlarm.route[routeIndex].node = metroStation1
            }
        default:
            let _ = 1
        }
    }
    
    func busCellUpdate(routeIndex:Int){
        let waypoint = workingAlarm.route[routeIndex]
        if(waypoint.type == .bus && waypoint.onboarding){
            let busStop = waypoint.node as! BusStop
            let buslist = busStop.selectedBusList
            
            for bus in buslist{
                bus.decreaseRemainingTime()
            }
        }
    }
    
}

var pathFindingMetroStations = [MetroStation(name: "", line: "", direction: "", trainList: [Train(timeRemaining: "", currentStation: "", terminalStation: ""),Train(timeRemaining: "", currentStation: "", terminalStation: "")]),MetroStation(name: "", line: "", direction: "", trainList: [Train(timeRemaining: "", currentStation: "", terminalStation: ""),Train(timeRemaining: "", currentStation: "", terminalStation: "")])]
