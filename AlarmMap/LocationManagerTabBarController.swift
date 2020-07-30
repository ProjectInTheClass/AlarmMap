//
//  LocationManagerTabBarController.swift
//  AlarmMap
//
//  Created by 윤성우 on 2020/06/02.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import CoreLocation

enum RoutingState {
    case start, routing, finish, blocked, notifying
}

class LocationManagerTabBarController: UITabBarController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // set UNUserNotificationCenter delegate to self
        UNUserNotificationCenter.current().delegate = self
        globalNotificationManager = UNUserNotificationCenter.current()
        // TODO
        //scheduleNotifications()

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
        locationManager.showsBackgroundLocationIndicator = true // show on status bar
        //locationManager.showsBackgroundLocationIndicator = false // TODO - You so bad code...
        locationManager.distanceFilter = 5.0
        //locationManager.activityType = .otherNavigation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        globalManager = locationManager
        
        // by CSEDTD - 백그라운드 타협 background
        // TODO - You so bad code...
        /*
        globalManager.startUpdatingLocation()
        if headingAvailable {
            globalManager.startUpdatingHeading()
        }
        globalManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        globalManager.distanceFilter = CLLocationDistanceMax
         */
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
                    
                    if(distance<1){
                        currentDistance = 1
                    }
                    else{
                        currentDistance = distance
                    }
                    
//                    let locNotManager = LocalNotificationManager()
//                    locNotManager.requestPermission()
//                    locNotManager.addNotification(title: /*"lat: " + (String(coor.latitude)) + " lon: " + String(coor.longitude) + TODO */" distance: " + String(distance))
//                    locNotManager.scheduleNotifications()
                    
                    //kloong
                    workingAlarm.pathFindingTV?.reloadData()
                    
                    // by CSEDTD
                    // TODO - 중간도착
                    if distance < workingAlarm.route[workingAlarm.routeIndex].radius!  && distance >= 0.0 && workingAlarm.routeIndex < workingAlarm.route.count - 1 && workingAlarm.routeIndex >= 0 {
                        
                        workingAlarm.routeIndex += 1
                        currentDestination = workingAlarm.getCurrentDestination()
                        
                        // TODO
                        scheduleNotifications(state: .routing, sender: workingAlarm)
                        notificationAlarm.finish()
                        notificationAlarm.start()
                        notificationAlarmCount = 2
                        /*
                        let locNotManager = LocalNotificationManager()
                        locNotManager.requestPermission()
                        locNotManager.addNotification(title: "중간도착!")
                        locNotManager.scheduleNotifications()
                         */
                        
                        //kloong
                        workingAlarm.pathFindingTV?.reloadData()
                        
                    }
                    // TODO - 최종도착, 알람 꺼짐
                    else if distance < workingAlarm.route[workingAlarm.routeIndex].radius! && distance >= 0.0 && workingAlarm.routeIndex == workingAlarm.route.count - 1 && workingAlarm.route[workingAlarm.routeIndex].type == .end {
                        
                        // TODO
                        scheduleNotifications(state: .finish, sender: workingAlarm)
                        workingAlarm.finished()
                        
                        /*
                        let locNotManager = LocalNotificationManager()
                        locNotManager.requestPermission()
                        locNotManager.addNotification(title: "길찾기 종료!")
                        locNotManager.scheduleNotifications()
                         */
                        
                        //kloong
                        workingAlarm.pathFindingTV?.reloadData()
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

// for foreground notification
extension LocationManagerTabBarController: UNUserNotificationCenterDelegate {

    //for displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        //If you don't want to show notification when app is open, do something here else and make a return here.
        //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.

        completionHandler([.alert, .badge, .sound])
    }

    // For handling tap and user actions
    // TODO
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        switch response.actionIdentifier {
        case "stopRouting":
            workingAlarm.finished()
        default:
            break
        }
        completionHandler()
    }

}

// TODO MUST 0623
func scheduleNotifications(state: RoutingState, sender: RouteAlarm) {

    let content = UNMutableNotificationContent()
    let requestIdentifier = UUID().uuidString

    // TODO
    content.badge = 0
    switch state {
    case .start:
        if workingAlarmExists == true && sender.repeats == true {
            content.title = "오류 발생"
            content.subtitle = ""
            content.body = ""
            content.categoryIdentifier = "simpleCategory"
        }
        else {
            // by ACSEDTD
            let startingPointString: String =  sender.getStartingPointString()
            let currentDestinationString: String =  sender.getCurrentDestinationString()
            let finalDestinationString: String =  sender.getFinalDestinationString()

            content.title = "'" + sender.routeTitle + "' 이동 시작!"
            content.subtitle = startingPointString + " ➔ " + finalDestinationString
            content.body = "'" + currentDestinationString + "' 으로 이동하세요." //"다음 행선지는 '" + currentDestinationString + "'입니다."
            content.categoryIdentifier = "actionCategory"
        }
    case .routing:
        // by ACSEDTD
        let startingPointString: String = sender.getStartingPointString()
        let currentDestinationString: String = sender.getCurrentDestinationString()
        let finalDestinationString: String = sender.getFinalDestinationString()
        // by ACSEDTD
        let currentWaypoint: WayPoint = sender.route[sender.routeIndex-1]
        let nextWaypoint: WayPoint = sender.route[sender.routeIndex]
        
        content.title = "'" + sender.routeTitle + "' 중간 도착!"
        content.subtitle = ""//"현재 위치: " + currentWaypoint.location.name //startingPointString + " ➔ " + finalDestinationString
        content.body = ""
        switch currentWaypoint.type {
        case .bus:
            // by ACSEDTD
            if currentWaypoint.onboarding == true {
                let busStop: BusStop = currentWaypoint.node as! BusStop
                let buses = busStop.selectedBusList.reduce("", {(busListText, bus) -> String in
                    return busListText + " " + bus.busNumber + "번"
                })
                
                content.subtitle += "버스가 "
                
                if busStop.selectedBusList.filter({ (a) -> Bool in
                    return a.firstBusRemainingTime.hasPrefix("곧")
                }).isEmpty == false {
                    content.subtitle += "곧 도착합니다."
                } else {
                    let remainingTimeArray = busStop.selectedBusList.filter({ (a) -> Bool in
                        return a.firstBusRemainingTime.contains("분") || a.firstBusRemainingTime.contains("초")
                    })
                    if remainingTimeArray.isEmpty == false {
                        if remainingTimeArray.filter({ (a) -> Bool in
                            return a.firstBusRemainingTime.contains("분")
                        }).isEmpty {
                            content.subtitle += "곧 도착합니다."
                        } else {
                            let minimumRemainingTime: Int = remainingTimeArray.map({ (a) -> Int? in
                                return Int(String(a.firstBusRemainingTime[..<(a.firstBusRemainingTime.firstIndex(of: "분") ?? a.firstBusRemainingTime.endIndex)]))
                            }).map ({ (a) -> Int in
                                return a ?? -1
                            }).min()!
                            
                            if minimumRemainingTime != -1 {
                                content.subtitle += "\(minimumRemainingTime)분 후에 도착합니다."
                            } else {
                                content.body += "It can't happen."
                            }
                        }
                    } else {
                        content.subtitle += "없습니다."
                    }
                }
                content.body += "탑승할 버스는" + buses + "입니다.\n버스를 타고 "
            } else {
                content.body += "'" + currentWaypoint.toString() + "'에서 하차하시고,\n"//"이번 정류장에서 하차하세요."
            }
        case .metro:
            // TODO - by ACSEDTD
            if currentWaypoint.onboarding == true {
                /* TODO
                let metroStation: MetroStation = currentWaypoint.node as! MetroStation
                
                // TODO - by CSEDTD
                content.subtitle += "지하철이 "
                
                if metroStation.direction == "내선" || metroStation.direction == "상행" {

                } else if metroStation.direction == "외선" || metroStation.direction == "하행" {
                    
                } else if metroStation.direction == "미정" {

                } else {
                    
                }
                
                if let firstTrain = metroStation.trainList.first {
                    
                    if firstTrain.timeRemaining.hasPrefix("곧") || firstTrain.timeRemaining.hasSuffix("출발") || firstTrain.timeRemaining.hasSuffix("진입") || firstTrain.timeRemaining.hasSuffix("도착") {
                        content.subtitle += "곧 도착합니다."
                    } else {
                        if firstTrain.timeRemaining.contains("분") {
                            if let remainingTime: Int = Int(String(firstTrain.timeRemaining[..<(firstTrain.timeRemaining.firstIndex(of: "분") ?? firstTrain.timeRemaining.endIndex)])) {
                                content.subtitle += "\(remainingTime)분 후에 도착합니다."
                            } else {
                                content.subtitle += "It can't happen."
                            }
                        } else {
                            content.subtitle += "It can't happen."
                        }
                    }
                } else {
                    content.subtitle += "없습니다."
                }
                
                content.body += "탑승할 지하철은 " + metroStation.direction + "입니다.\n지하철을 타고 "
            */
            } else {
                content.body += "'" + currentWaypoint.toString() + "'에서 하차하시고,\n"//"이번 역에서 하차하세요."
            }
        case .walk:
            content.body += "예상 도보 시간은 " +  String(currentWaypoint.takenSeconds) + "초 입니다.\n"
        case .end:
            // by ACSEDTD
            content.body += "It can't happen.\n"
            
        }
        
        if nextWaypoint.onboarding == true {
            
            if nextWaypoint.type == .bus {
                
                let busStop: BusStop = nextWaypoint.node as! BusStop

                content.subtitle += "버스가 "
                
                if busStop.selectedBusList.filter({ (a) -> Bool in
                    return a.firstBusRemainingTime.hasPrefix("곧")
                }).isEmpty == false {
                    content.subtitle += "곧 도착합니다."
                } else {
                    let remainingTimeArray = busStop.selectedBusList.filter({ (a) -> Bool in
                        return a.firstBusRemainingTime.contains("분") || a.firstBusRemainingTime.contains("초")
                    })
                    if remainingTimeArray.isEmpty == false {
                        if remainingTimeArray.filter({ (a) -> Bool in
                            return a.firstBusRemainingTime.contains("분")
                        }).isEmpty {
                            content.subtitle += "곧 도착합니다."
                        } else {
                            let minimumRemainingTime: Int = remainingTimeArray.map({ (a) -> Int? in
                                return Int(String(a.firstBusRemainingTime[..<(a.firstBusRemainingTime.firstIndex(of: "분") ?? a.firstBusRemainingTime.endIndex)]))
                            }).map ({ (a) -> Int in
                                return a ?? -1
                            }).min()!
                            
                            if minimumRemainingTime != -1 {
                                content.subtitle += "\(minimumRemainingTime)분 후에 도착합니다."
                            } else {
                                content.body += "It can't happen."
                            }
                        }
                    } else {
                        content.subtitle += "없습니다."
                    }
                }
            } else if nextWaypoint.type == .metro {
                /* TODO
                let metroStation: MetroStation = nextWaypoint.node as! MetroStation
                
                content.subtitle += "지하철이 "
                
                if let firstTrain = metroStation.trainList.first {
                    
                    if firstTrain.timeRemaining.hasPrefix("곧") ||  firstTrain.timeRemaining.hasSuffix("출발") || firstTrain.timeRemaining.hasSuffix("진입") || firstTrain.timeRemaining.hasSuffix("도착") {
                        content.subtitle += "곧 도착합니다."
                    } else {
                        if firstTrain.timeRemaining.contains("분") {
                            if let remainingTime: Int = Int(String(firstTrain.timeRemaining[..<(firstTrain.timeRemaining.firstIndex(of: "분") ?? firstTrain.timeRemaining.endIndex)])) {
                                content.subtitle += "\(remainingTime)분 후에 도착합니다."
                            } else {
                                content.subtitle += "It can't happen."
                            }
                        } else {
                            content.subtitle += "It can't happen."
                        }
                    }
                } else {
                    content.subtitle += "없습니다."
                }
                 */
            }
        }
        
        if (currentWaypoint.type == .bus || currentWaypoint.type == .metro) && (currentWaypoint.onboarding == false) && (nextWaypoint.type == .bus || nextWaypoint.type == .metro) && (nextWaypoint.onboarding == true) {
            content.body += "'" + currentDestinationString + "'으로 환승하세요."
        } else {
            content.body += "'" + currentDestinationString + "'으로 이동하세요."//"다음 행선지는 '" + currentDestinationString + "'입니다.\n"
        }
        content.categoryIdentifier = "actionCategory"
    case .finish:
        content.title = "'" + sender.routeTitle + "' 이동 종료!"
        content.subtitle = ""
        content.body = ""
        content.categoryIdentifier = "simpleCategory"
    case .blocked:
        content.title = "이미 실행 중인 경로탐색이 존재하여"
        content.subtitle = sender.routeTitle + " 경로탐색이 무시되었습니다."
        content.body = ""
        content.categoryIdentifier = "simpleCategory"
    case .notifying:
        // by ACSEDTD
        let nextWaypoint: WayPoint = sender.route[sender.routeIndex]
        
        if nextWaypoint.type == .bus && nextWaypoint.onboarding == true && notificationAlarmCount > 0 {
            let currentDestinationString: String = sender.getCurrentDestinationString()
            let busStop: BusStop = nextWaypoint.node as! BusStop
            let urgentBusArray: [Bus] = busStop.selectedBusList.filter{ (a) -> Bool in
                return a.firstBusRemainingTime.hasPrefix("곧") || a.firstBusRemainingTime.hasPrefix("0분") || a.firstBusRemainingTime.hasPrefix("1분") || a.firstBusRemainingTime.hasPrefix("2분")
            }
            
            if !urgentBusArray.isEmpty {
                content.title = "서두르세요!"
                content.subtitle = ""
                content.body = "'" + currentDestinationString + "'으로 오는" + urgentBusArray.reduce("", {(busListText, bus) -> String in
                    return busListText + " " + bus.busNumber + "번"
                }) + " 버스가 곧 도착해요!"
                notificationAlarmCount -= 1
            } else {
                return
            }
        } else if nextWaypoint.type == .metro && nextWaypoint.onboarding == true && notificationAlarmCount > 0 {
            /* TODO
            let currentDestinationString: String = sender.getCurrentDestinationString()
            let metroStation: MetroStation = nextWaypoint.node as! MetroStation
            if let firstTrain = metroStation.trainList.first {
                if firstTrain.timeRemaining.hasPrefix("곧") || firstTrain.timeRemaining.hasSuffix("출발") || firstTrain.timeRemaining.hasSuffix("진입") || firstTrain.timeRemaining.hasSuffix("도착") || firstTrain.timeRemaining.hasPrefix("0분") || firstTrain.timeRemaining.hasPrefix("1분") || firstTrain.timeRemaining.hasPrefix("2분") {
                    content.title = "서두르세요!"
                    content.subtitle = ""
                    content.body = "'" + currentDestinationString + "'으로 오는 열차가 곧 도착해요!"
                    notificationAlarmCount -= 1
                } else {
                    return
                }
            } else {
                return
            }
             */
        } else {
            return
        }
        content.categoryIdentifier = "actionCategory"
    }
    content.sound = UNNotificationSound.default

    // If you want to attach any image to show in local notification
    /*
    let url = Bundle.main.url(forResource: "notificationImage", withExtension: ".jpg")
    do {
        let attachment = try? UNNotificationAttachment(identifier: requestIdentifier, url: url!, options: nil)
        content.attachments = [attachment!]
    }
     */

    let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)

    let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request) { (error:Error?) in

        if error != nil {
            print(error?.localizedDescription ?? "some unknown error")
        }
        print("Notification Register Success")
    }
}

// TODO
func registerForRichNotifications() {

   UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted:Bool, error:Error?) in
        if error != nil {
            print(error?.localizedDescription)
        }
        if granted {
            print("Permission granted")
        } else {
            print("Permission not granted")
        }
    }

    //actions defination
    let stopRouting = UNNotificationAction(identifier: "stopRouting", title: "이동 중지", options: [.foreground])

    let actionCategory = UNNotificationCategory(identifier: "actionCategory", actions: [stopRouting], intentIdentifiers: [], options: [])
    
    let simpleCategory = UNNotificationCategory(identifier: "simpleCategory", actions: [], intentIdentifiers: [], options: [])

    UNUserNotificationCenter.current().setNotificationCategories([actionCategory, simpleCategory])

}

var headingAvailable = false
var notificationAuthorized = true
var locationAuthorized = true

// 위치 정보를 관리하는 reference
// 현재 위치 위도/경도를 알고 싶다면 globalManager.location?.coordinate.latitude(또는 longitude) <-- Double
var globalManager = CLLocationManager()
var globalNotificationManager = UNUserNotificationCenter.current()

var currentDistance: Double = -1.0
