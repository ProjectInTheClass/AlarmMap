//
//  Metro.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/04/24.
//  Copyright © 2020 Kloong. All rights reserved.
//

import Foundation
import UIKit

/*지하철

지하철역 구조체
멤버: 역 이름, 호선, 방면, 지하철 list

지하철 list의 노드 구조체
멤버: 남은 시간, 현재역, 종착역*/

struct Train {
    var timeRemaining: String
    var currentStation: String
    let terminalStation: String
}

struct MetroStation {
    let name: String
    let line: String
    let direction: String
    var trainList: [Train]
}

let trainListOfStationA: [Train] =
[Train(timeRemaining: "곧 도착", currentStation: "미아사거리", terminalStation: "사당행"),
Train(timeRemaining: "3분", currentStation: "미아", terminalStation: "오이도행"),
Train(timeRemaining: "8분", currentStation: "쌍문", terminalStation: "사당행"),
Train(timeRemaining: "dummy", currentStation: "dummy", terminalStation: "dummy")]

let trainListOfStationB: [Train] =
[Train(timeRemaining: "4분", currentStation: "시청", terminalStation: "성수행"),
Train(timeRemaining: "8분", currentStation: "아현", terminalStation: "성수행"),
Train(timeRemaining: "10분", currentStation: "이대", terminalStation: "성수행"),
Train(timeRemaining: "dummy", currentStation: "dummy", terminalStation: "dummy")]

let trainListOfStationC: [Train] =
[Train(timeRemaining: "2분", currentStation: "뚝섬", terminalStation: "성수행"),
Train(timeRemaining: "4분", currentStation: "성수", terminalStation: "성수행"),
Train(timeRemaining: "열차X", currentStation: "", terminalStation: ""),
Train(timeRemaining: "열차X", currentStation: "", terminalStation: "")]

let stationA: MetroStation =
    MetroStation(name: "길음", line: "4호선", direction: "성신여대입구 방면", trainList: trainListOfStationA)

let stationB: MetroStation =
    MetroStation(name: "동대문역사문화공원", line: "2호선", direction: "신당 방면", trainList: trainListOfStationB)

let stationC: MetroStation =
    MetroStation(name: "한양대", line: "2호선", direction: "왕십리 방면", trainList: trainListOfStationC)

var stationList:[MetroStation] = [stationA, stationB, stationC]

func lineColor(line:String) -> UIColor {
    switch line {
    case "4호선":
        return .blue
    case "2호선":
        return .green
    default:
        return .white
    }
}

