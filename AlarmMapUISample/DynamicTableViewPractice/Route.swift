//
//  Route.swift
//  TableViewPractice
//
//  Created by 김요환 on 2020/04/23.
//  Copyright © 2020 Kloong. All rights reserved.
//

import Foundation

struct Route{
    var name : String
    var subtitle: String;
}

var monRoute: Route = Route(name: "월요일", subtitle:  "")
var tueRoute: Route = Route(name: "화요일", subtitle: "한양대학교 10:25")
var wedRoute: Route = Route(name: "수요일", subtitle: "한양대학교 15:50")
var thuRoute: Route = Route(name: "목요일", subtitle: "한양대학교 15:50")
var friRoute: Route = Route(name: "금요일", subtitle: "한양대학교 13:20")
var satRoute: Route = Route(name: "토요일", subtitle: "")
var sunRoute: Route = Route(name: "일요일", subtitle: "교회 09:30")

let dailyRoute : [Route] = [monRoute,tueRoute,wedRoute,thuRoute,friRoute,satRoute,sunRoute]

var route1: Route = Route(name: "한양대학교", subtitle: "")
var route2: Route = Route(name: "한양대학교->집", subtitle: "")
var route3: Route = Route(name: "합주실", subtitle: "")
var route4: Route = Route(name: "한양대학교->합주실", subtitle: "")

var favoriteRoute : [Route] = [route1, route2, route3, route4]

var routeSections: [[Route]] = [dailyRoute,favoriteRoute]

let routeSectionsHeader: [String] = ["요일별","즐겨찾기"]

struct RepetitionDateStruct {
    let dateList = ["일 ","월 ","화 ","수 ","목 ","금 ","토"]
    var repetitionDateFlags = [false,false,false,false,false,false,false]
    
    func toString() -> String {
        var repetitionDate = String()
        for (index,repetitionDateFlag) in repetitionDateFlags.enumerated() {
            if repetitionDateFlag {
                repetitionDate.append(dateList[index])
            }
        }
        return repetitionDate
    }
}
