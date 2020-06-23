//
//  PathFindingParentsViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/23.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class PathFindingParentsViewController: UIViewController {
    
    @IBOutlet var routeTitleLabel: UILabel!
    
    @IBOutlet var routeSubtitleLabel: UILabel!
    
    @IBOutlet var currentLocationProgView: UIProgressView!
    
    @IBOutlet var routeRemainingTimeLabel: UILabel!
    
    var pathFindingTV:UITableView? = nil
    var pathInfoUpdateTimer:Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray4

        currentLocationProgView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        workingAlarm.pathFindingTV = self.pathFindingTV
        
        if(workingAlarm.routeIndex >= 0){
            routeTitleLabel.text = workingAlarm.routeTitle
            routeSubtitleLabel.text = workingAlarm.routeSubtitle
            pathInfoUpdate()
            //pathFindingTV?.reloadData()
            
            if(pathInfoUpdateTimer == nil){
                pathInfoUpdateTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(pathInfoUpdate), userInfo: nil, repeats: true)
            }
            else{
                if(!(pathInfoUpdateTimer!.isValid)){
                    pathInfoUpdateTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(pathInfoUpdate), userInfo: nil, repeats: true)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(pathInfoUpdateTimer != nil && pathInfoUpdateTimer!.isValid){
            pathInfoUpdateTimer?.invalidate()
        }
    }
    
    @objc func pathInfoUpdate(){
        if(workingAlarm.routeIndex < 0){
            pathInfoUpdateTimer?.invalidate()
            return
        }
        
        var remainingTime = 0
        
        //workingAlarm.distance가 없음!!
//        var distToNextWaypointPropotion = Double(workingAlarm.distance) / Double(workingAlarm.route[workingAlarm.routeIndex].distance)
//        remainingTime = Int(round((Double(workingAlarm.route[workingAlarm.routeIndex].takenSeconds) * distToNextWaypointPropotion)))
        
        for index in (workingAlarm.routeIndex+1)...(workingAlarm.route.count-1){
            remainingTime += Int(round(Double(workingAlarm.route[index].takenSeconds)/60.0))
        }
        
        routeRemainingTimeLabel.text = "약 \(remainingTime)분 후 도착 예정입니다."
        
        currentLocationProgView.progress = 1.0 - Float(remainingTime) /  Float(workingAlarm.routeTotalTime)
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
            workingAlarm.finished()
            self.pathFindingTV!.reloadData()
        })
        
        settingPathFinding.addAction(startPathFinding)
        settingPathFinding.addAction(stopPathFinding)
        
        let cancle = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        settingPathFinding.addAction(cancle)
               
        self.present(settingPathFinding, animated: true, completion: nil)
    }
}
