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
            print("Device Error: CLLocationManager.isRangingAvailable() is false.")
        }
        if !CLLocationManager.locationServicesEnabled() {
            print("Device Error: CLLocationManager.locationServicesEnabled() is false.")
        }
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization() // 권한 요청
        locationManager.allowsBackgroundLocationUpdates = true // ignore suspend
        locationManager.showsBackgroundLocationIndicator = false // show on status bar // TODO - You so bad code...
        locationManager.distanceFilter = 5.0
        //locationManager.activityType = .otherNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        globalManager = locationManager
        
        // by CSEDTD - 백그라운드 타협 background
        // TODO
        globalManager.startUpdatingLocation()
        if headingAvailable {
            globalManager.startUpdatingHeading()
        }
        globalManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        globalManager.distanceFilter = CLLocationDistanceMax
    }
    
    // On updating location
    // 장소 (5m) 바뀔 때마다 호출됨
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coor = manager.location?.coordinate {
            print("latitude: " + String(coor.latitude) + " / longitude: " + String(coor.longitude))
            
            // by CSEDTD - 알람이 돌아가는 상황
            if workingAlarmExists && workingAlarm.isOn && workingAlarm.infoIsOn {
                if let distance = (manager.location?.distance(from: CLLocation(latitude: currentDestination.latitude
                    , longitude: currentDestination.longitude))) {
                    
                    let locNotManager = LocalNotificationManager()
                    locNotManager.requestPermission()
                    locNotManager.addNotification(title: /*"lat: " + (String(coor.latitude)) + " lon: " + String(coor.longitude) + TODO */" dist: " + String(distance))
                    locNotManager.scheduleNotifications()
                    
                    // by CSEDTD
                    // 중간도착
                    if distance < 20.0 && distance >= 0.0 && workingAlarm.routeIndex < workingAlarm.route.count - 1 && workingAlarm.routeIndex >= 0 {
                        
                        workingAlarm.routeIndex += 1
                        currentDestination = workingAlarm.getCurrentDestination()
                        
                        let locNotManager = LocalNotificationManager()
                        locNotManager.requestPermission()
                        locNotManager.addNotification(title: "중간도착!")
                        locNotManager.scheduleNotifications()
                        
                        
                    }
                    // 최종도착, 알람 꺼짐
                    else if distance < (workingAlarm.route.last?.radius)! && distance >= 0.0 && workingAlarm.routeIndex == workingAlarm.route.count - 1 {
                        
                        workingAlarm.finished()
                        
                        let locNotManager = LocalNotificationManager()
                        locNotManager.requestPermission()
                        locNotManager.addNotification(title: "길찾기 종료!")
                        locNotManager.scheduleNotifications()
                    }
                    else if distance < 0.0 {
                        print("ERROR: distance < 0.0 (LocationManagerTabBarController.swift)")
                    }
                }
                else {
                    print("ERROR: distance is NULL (LocationManagerTabBarController.swift)")
                }
            } else if (!workingAlarm.isOn) || (!workingAlarm.infoIsOn) { // by CSEDTD - RouteAlarmListTableViewController에서 알람 끈 상황
                /*
                currentDestination = Location()
                workingAlarm = RouteAlarm()
                workingAlarmExists = false
                globalManager.stopUpdatingLocation()
                
                if headingAvailable {
                    globalManager.stopUpdatingHeading()
                }
                 */
                workingAlarm.finished()
            }
            else {
                print("ERROR: Unpredictable error (LocationManagerTabBarController.swift")
            }
        }
    }
    
    // 방향이 (1도) 바뀔 때마다 호출됨
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        /* TODO
        print("heading x: \(newHeading.x)")
        print("heading y: \(newHeading.y)")
        */
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

// 위치 정보를 관리하는 reference
// 현재 위치 위도/경도를 알고 싶다면 globalManager.location?.coordinate.latitude(또는 longitude) <-- Double
var globalManager = CLLocationManager()

