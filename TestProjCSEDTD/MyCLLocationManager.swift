//
//  MyCLLocationManager.swift
//  TestProjCSEDTD
//
//  Created by 윤성우 on 2020/05/29.
//  Copyright © 2020 윤성우. All rights reserved.
//

import Foundation
import CoreLocation

class MyCLLocationManager {
    
    var locationManager: CLLocationManager
    
    init() {
        locationManager = CLLocationManager()
        //locationManager.delegate = self
        locationManager.requestAlwaysAuthorization() // 권한 요청
        locationManager.allowsBackgroundLocationUpdates = true // ignore suspend
        locationManager.showsBackgroundLocationIndicator = true // show on status bar
        locationManager.distanceFilter = 20.0
        //locationManager.activityType = .otherNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
}
