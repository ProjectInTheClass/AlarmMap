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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray4

        currentLocationProgView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
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
