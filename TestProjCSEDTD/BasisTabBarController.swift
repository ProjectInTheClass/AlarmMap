//
//  BasisTabBarController.swift
//  TestProjCSEDTD
//
//  Created by 윤성우 on 2020/05/28.
//  Copyright © 2020 윤성우. All rights reserved.
//

import UIKit
import CoreLocation

var headingAvailable = false
var isNavigating = false

var globalManager = CLLocationManager()

class BasisTabBarController: UITabBarController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        
        // Check Device's Support
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            print("Device Error: CLLocationManager.significantLocationChangeMonitoringAvailable() is false.")
        }
        if !CLLocationManager.headingAvailable() {
            print("Device Error: CLLocationManager.headingAvailable() is false.")
            headingAvailable = false
        } else {
            headingAvailable = true
        }
        if !CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            print("Device Error: CLLocationManager.isMonitoringAvailable() is false.")
        }
        if !CLLocationManager.isRangingAvailable() {
            print("Device Error: CLLocationManager.isRangingAvailable()")
        }
        if !CLLocationManager.locationServicesEnabled() {
            print("Device Error: CLLocationManager.locationServicesEnabled()")
        }
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization() // 권한 요청
        locationManager.allowsBackgroundLocationUpdates = true // ignore suspend
        locationManager.showsBackgroundLocationIndicator = true // show on status bar
        locationManager.distanceFilter = 20.0
        //locationManager.activityType = .otherNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        globalManager = locationManager
        globalManager.distanceFilter = 5.0
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // On updating location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coor = manager.location?.coordinate {
            print("latitude: " + String(coor.latitude) + " / longitude: " + String(coor.longitude)/* + " / Date: \(locations.last?.timestamp)"*/)
            
            let locNotManager = LocalNotificationManager()
            locNotManager.requestPermission()
            locNotManager.addNotification(title: "lat: " +  String(coor.latitude) + "  lon: " + String(coor.longitude))
            locNotManager.scheduleNotifications()
        }
        
        print(globalManager.distanceFilter)
        print(locationManager.distanceFilter)
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
