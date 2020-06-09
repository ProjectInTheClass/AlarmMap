//
//  BusListSettingViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/04.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusListSettingViewController: UIViewController {

    @IBOutlet var busStopNameLabel: UILabel!
    
    @IBOutlet var busStopDirectionLabel: UILabel!
    
    var busStop:BusStop? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        busStopNameLabel.text = busStop?.name
        
        busStopDirectionLabel.text = ""
        if let busStopDirection = busStop?.direction {
            busStopDirectionLabel.text = busStopDirection + " 방면"
        }
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "busListEmbedSegue"){
            let busSettingTVC = segue.destination as! BusListSettingTableViewController
            busSettingTVC.busStop = busStop
        }
    }

}
