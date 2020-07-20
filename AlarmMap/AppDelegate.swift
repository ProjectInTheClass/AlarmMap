//
//  AppDelegate.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/04/24.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // TODO
        registerForRichNotifications()
        GMSPlacesClient.provideAPIKey("AIzaSyAnY25SGc7S-6QhQxqk7kb0DaXrTg455LU")
        
        if let metroStationListData = UserDefaults.standard.data(forKey: "metroStationList"){
            if let tempMetroStationList = try? JSONDecoder().decode([MetroStation].self, from: metroStationListData){
                metroStationList = tempMetroStationList
            }
        }
        
        if let busStopListData = UserDefaults.standard.data(forKey: "busStopList"){
            if let tempBusStopList = try? JSONDecoder().decode([BusStop].self, from: busStopListData){
                busStopList = tempBusStopList
            }
        }
        
        if let routineRouteInfoListData = UserDefaults.standard.data(forKey: "routineRouteInfoList"){
            if let routineRouteInfoListCodable = try? JSONDecoder().decode([RouteInfo.CodableRouteInfoStruct].self, from: routineRouteInfoListData){
                routeCategoryList[0].routeInfoList = routineRouteInfoListCodable.map({(codableRouteInfoStruct) -> RouteInfo in
                    return codableRouteInfoStruct.toRouteInfoClassInstance()
                })
            }
        }
        
        if let favoritesRouteInfoListData = UserDefaults.standard.data(forKey: "favoritesRouteInfoList"){
            if let favoritesRouteInfoListCodable = try? JSONDecoder().decode([RouteInfo.CodableRouteInfoStruct].self, from: favoritesRouteInfoListData){
                routeCategoryList[1].routeInfoList = favoritesRouteInfoListCodable.map({(codableRouteInfoStruct) -> RouteInfo in
                    return codableRouteInfoStruct.toRouteInfoClassInstance()
                })
            }
        }
        
        usleep(500000)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

// TODO - If you want that your notification banner should be shown everywhere in the entire application
/*
 extension AppDelegate: UNUserNotificationCenterDelegate {
 
 func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
 print(response.notification.request.content.userInfo)
 completionHandler()
 }
 
 func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
 completionHandler([.alert, .badge, .sound])
 }
 }
 */
