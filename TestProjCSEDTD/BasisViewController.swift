//
//  BasisViewController.swift
//  TestProjCSEDTD
//
//  Created by 윤성우 on 2020/05/28.
//  Copyright © 2020 윤성우. All rights reserved.
//

import UIKit
import CoreLocation

var myManager = MyCLLocationManager()

class BasisViewController: UIViewController, CLLocationManagerDelegate {
        
    //var locationManager: CLLocationManager!
    //let runLoop = RunLoop.current

    override func viewDidLoad() {
        print("Hey!")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
/*
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

         
         
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization() // 권한 요청
        locationManager.allowsBackgroundLocationUpdates = true // ignore suspend
        locationManager.showsBackgroundLocationIndicator = true // show on status bar
        locationManager.distanceFilter = 20.0
        //locationManager.activityType = .otherNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
 */
    }

/*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNavigating {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
 */
    
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
    
    func labelUpdate(lat: Double, lon: Double) {
        if (latitudeLabel != nil) && (longitudeLabel != nil) && (timestampLabel != nil) {
            latitudeLabel.text = "lat: " + String(lat)
            longitudeLabel.text = "lon: " + String(lon)
        }
    }
  
/*
    // On updating location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coor = manager.location?.coordinate {
            print("latitude: " + String(coor.latitude) + " / longitude: " + String(coor.longitude)/* + " / Date: \(locations.last?.timestamp)"*/)
            if (latitudeLabel != nil) && (longitudeLabel != nil) && (timestampLabel != nil)  {
                latitudeLabel.text = "latitude: " + String(coor.latitude)
                longitudeLabel.text = "longitude: " + String(coor.longitude)
            }
            else{
                print("Is NULL!")
            }
            
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
*/
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var headingToXLabel: UILabel!
    
    @IBOutlet weak var headingToYLabel: UILabel!
    
    @IBOutlet weak var numOfAlarmsLabel: UILabel!
    
    @IBAction func navigationToggleButton(_ sender: UIButton) {
        //print(locationManager.distanceFilter)
        isNavigating = !isNavigating
        if isNavigating {
            globalManager.startUpdatingLocation()
            //locationManager.startUpdatingLocation()
            
            print("Toggle - on!")
        } else {
            globalManager.stopUpdatingLocation()
            //locationManager.stopUpdatingLocation()
            print("Toggle - off!")
        }
 
    }
    
    
}


