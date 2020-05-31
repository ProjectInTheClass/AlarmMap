//
//  DataCenter.swift
//  TestProjCSEDTD
//
//  Created by 윤성우 on 2020/05/30.
//  Copyright © 2020 윤성우. All rights reserved.
//

import Foundation

class DataCenter {
    
    var lat: Double
    var lon: Double
    
    init() {
        lat = Double()
        lon = Double()
    }
    
    func patchGPS(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    func getLat() -> Double {
        return self.lat
    }
    func getLon() -> Double {
        return self.lon
    }
}

let refDataCenter = DataCenter()
