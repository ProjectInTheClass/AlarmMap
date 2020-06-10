//
//  BusListSettingViewController.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/04.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusListSettingParentsViewController: UIViewController {
    
    var busStop:BusStop? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "busListTableviewEmbedSegue"){
            let busListSettingTVC = segue.destination as! BusListSettingTableViewController
            busListSettingTVC.busStop = busStop
        }
        else{ //busListViewEmbedSegue
            let busListSettingVC = segue.destination as! BusListSettingViewController
            busListSettingVC.busStop = busStop
            
        }
    }

}
