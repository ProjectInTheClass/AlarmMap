//
//  TestViewController.swift
//  AlarmMap
//
//  Created by 윤성우 on 2020/06/04.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addAnAlarm(_ sender: Any) {
        RouteAlarm(time: Date(timeIntervalSinceNow: 0), routeInfo: RouteInfo())
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
