//
//  LocationManagerTabBarController.swift
//  AlarmMap
//
//  Created by 윤성우 on 2020/06/02.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManagerTabBarController: UITabBarController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        print("hhhhhhhhhhhey!")
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
        locationManager.distanceFilter = 5.0
        //locationManager.activityType = .otherNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        globalManager = locationManager
    }
    
    // On updating location
    // 장소 (5m) 바뀔 때마다 호출됨
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coor = manager.location?.coordinate {
            print("latitude: " + String(coor.latitude) + " / longitude: " + String(coor.longitude))
            
            // by CSEDTD - 알람이 돌아가는 상황
            if workingAlarmExists && workingAlarm.isOn {
                if let distance = (manager.location?.distance(from: CLLocation(latitude: currentDestination.latitude
                    , longitude: currentDestination.longitude))) {
                    
                    print("distance: \(distance)")
                    
                    // by CSEDTD - 도착함, 알람 꺼짐
                    if distance < 20.0 && distance >= 0.0 {
                        currentDestination = Location()
                        workingAlarm = RouteAlarm()
                        workingAlarmExists = false
                        globalManager.stopUpdatingLocation()
                        
                        if headingAvailable {
                            globalManager.stopUpdatingHeading()
                        }
                    }
                    else if distance < 0.0 {
                        print("ERROR: distance < 0.0 (LocationManagerTabBarController.swift)")
                    }
                }
                else {
                    print("ERROR: distance is NULL (LocationManagerTabBarController.swift)")
                }
            } else if !workingAlarm.isOn { // by CSEDTD - RouteAlarmListTableViewController에서 알람 끈 상황
                currentDestination = Location()
                workingAlarm = RouteAlarm()
                workingAlarmExists = false
                globalManager.stopUpdatingLocation()
                
                if headingAvailable {
                    globalManager.stopUpdatingHeading()
                }
            }
        }
    }
    
    // 방향이 (1도) 바뀔 때마다 호출됨
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("heading x: \(newHeading.x)")
        print("heading y: \(newHeading.y)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedAlways {
            manager.requestAlwaysAuthorization()
            locationManager.allowsBackgroundLocationUpdates = true // ignore suspend
        }
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

var headingAvailable = false
var isNavigating = false

// 위치 정보를 관리하는 reference
// 현재 위치 위도/경도를 알고 싶다면 globalManager.location?.coordinate.latitude(또는 longitude) <-- Double
var globalManager = CLLocationManager()

