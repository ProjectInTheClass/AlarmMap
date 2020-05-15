//
//  Route.swift
//  TableViewPractice
//
//  Created by 김요환 on 2020/04/23.
//  Copyright © 2020 Kloong. All rights reserved.
//

//  @IBOutlet var routeTitleCell: UITableViewCell!
//
//   @IBOutlet var routeTitleTextField: UITextField!
//
//   @IBOutlet var routeSubtitleTextField: UITextField!
//
//   @IBOutlet var startingPointLabel: UILabel!
//
//   @IBOutlet var destinationLabel: UILabel!
//
//   @IBOutlet var arrivalTimeLabel: UILabel!
//
//   @IBOutlet var arrivalTimeDatePicker: UIDatePicker!
//
//   @IBOutlet var repetitionLabel: UILabel!
//
//   @IBOutlet var dateLabel: UILabel!
//
//   @IBOutlet var datePicker: UIDatePicker!

import Foundation

struct RouteSection{
    var title: String
    var routeInfoList: [RouteInfo]
}

class RouteInfo{
    var title : String
    var subtitle: String
    
    var route: Route // 얘는 string이 아니라 실제 경로에 대한 정보를 담고 있어야 한다.
    
    var arrivalTime : Date
    var repetitionDate: RepetitionDate
    var scheduledDate: Date

    //임시 init
    init(){
        self.title = ""
        self.subtitle = ""
        self.route = Route()
        self.arrivalTime = Date()
        self.repetitionDate = RepetitionDate()
        self.scheduledDate = Date()
    }
}

class Route{
    //startingPoint와 destinationPoint는 String이 아니라 Location 정보를 담고 있어야 함.
    var startingPoint: String
    var destinationPoint: String

    var somethingNeed: String
    //실제 경로(버스, 지하철, 출발지, 도착지 등)
    
    //임시 init
    init() {
        self.startingPoint = ""
        self.destinationPoint = ""
        self.somethingNeed = ""
    }
}

class RepetitionDate{
    let dateList = ["일 ","월 ","화 ","수 ","목 ","금 ","토"]
    var repetitionDateFlags = [false,false,false,false,false,false,false]
    
    func anyRepetitionDate() -> Bool {
        return repetitionDateFlags.contains(true)
    }
    
    func toString() -> String {
        var repetitionDate = String()
        
        for (index,repetitionDateFlag) in repetitionDateFlags.enumerated() {
            if repetitionDateFlag {
                repetitionDate.append(dateList[index])
            }
        }
        
        if (repetitionDate == "") {
            repetitionDate = "안 함"
        }
        
        return repetitionDate
    }
    
}

enum SectionsEnum{
    case routine, favorites
    
    func toInt() -> Int{
        switch self {
        case .routine:
            return 0
        default:
            return 1
        }
    }
}

var routineSection = RouteSection(title: "일상", routeInfoList: [RouteInfo]())
var favoritesSection = RouteSection(title: "즐겨찾기", routeInfoList: [RouteInfo]())
var routeSectionList = [routineSection, favoritesSection]


