//
//  MyCLLocationManager.swift
//  TestProjCSEDTD
//
//  Created by 윤성우 on 2020/05/29.
//  Copyright © 2020 윤성우. All rights reserved.
//

import Foundation
import CoreLocation

class MyCLLocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        
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
    }

    // On updating heading
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("heading X: " + String(newHeading.x))
        print("heading Y: " + String(newHeading.y))
        print("heading Z: " + String(newHeading.z))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedAlways {
            manager.requestAlwaysAuthorization()
        }
    }
}

var myGPS = MyCLLocationManager()
