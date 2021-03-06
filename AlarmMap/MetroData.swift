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
func lineTosubwayId(line:String) -> String{
    switch line {
    case "1호선":
        return "1001"
    case "2호선":
        return "1002"
    case "3호선":
        return "1003"
    case "4호선":
        return "1004"
    case "5호선":
        return "1005"
    case "6호선":
        return "1006"
    case "7호선":
        return "1007"
    case "8호선":
        return "1008"
    case "9호선":
        return "1009"
    case "경의중앙선":
        return "1063"
    case "공항철도":
        return "1065"
    case "경춘선":
        return "1067"
    case "수인선":
        return "1071"
    case "분당선":
        return "1075"
    case "신분당선":
        return "1077"
    case "자기부상":
        return "1091"
    case "우이신설선":
        return "1092"
    default:
        return "nope"
    }
}

func subwayIdToLine(line:String) -> String{
    switch line {
    case "1001":
        return "1호선"
    case "1002":
        return "2호선"
    case "1003":
        return "3호선"
    case "1004":
        return "4호선"
    case "1005":
        return "5호선"
    case "1006":
        return "6호선"
    case "1007":
        return "7호선"
    case "1008":
        return "8호선"
    case "1009":
        return "9호선"
    case "1063":
        return "경의중앙선"
    case "1065":
        return "공항철도"
    case "1067":
        return "경춘선"
    case "1071":
        return "수인선"
    case "1075":
        return "분당선"
    case "1077":
        return "신분당선"
    case "1091":
        return "자기부상"
    case "1092":
        return "우이신설선"
    default:
        return "nope"
    }
}

func eraseSeconds(timeRemaining:String) -> String{
    var retString:String = ""
    if(timeRemaining.contains("분")){
        
        for c in timeRemaining{
            retString += String(c)
            if (c == "분") {
                break
            }
        }
    }
    else if(timeRemaining.contains("초") && timeRemaining.contains("후")){
        retString = "곧 도착"
    }
    else{
        retString = timeRemaining
    }
    return retString
}

struct MetroPair {
    let name:String
    let line:String
}

struct Train: Codable {
    var timeRemaining: String
    var currentStation: String
    let terminalStation: String
}

class MetroStation: Node, Codable{
    let name: String
    let line: String
    let direction: String // way in ODSAY
    var trainList: [Train]
    
    init(name:String, line:String,direction:String,trainList:[Train]){
        self.name = name
        self.line = line
        self.direction = direction
        self.trainList = trainList
    }
}



var metroStationList:[MetroStation] = []//[stationA, stationB, stationC]

func lineColor(line:String) -> UIColor {
    switch line {
    case "1호선":
        return UIColor(red: 0, green: 50/255.0, blue: 160/255.0, alpha: 1)
    case "2호선":
        return UIColor(red: 0, green: 177/255.0, blue: 64/255.0, alpha: 1)
    case "3호선":
        return UIColor(red: 252/255.0, green: 76/255.0, blue: 2/255.0, alpha: 1)
    case "4호선":
        return UIColor(red: 0, green: 169/255.0, blue: 224/255.0, alpha: 0.9)
    case "5호선":
        return UIColor(red: 160/255.0, green: 94/255.0, blue: 181/255.0, alpha: 1)
    case "6호선":
        return UIColor(red: 169/255.0, green: 67/255.0, blue: 30/255.0, alpha: 0.8)
    case "7호선":
        return UIColor(red: 109/255.0, green: 113/255.0, blue: 46/255.0, alpha: 1)
    case "8호선":
        return UIColor(red: 227/255.0, green: 28/255.0, blue: 121/255.0, alpha: 1)
    case "9호선":
        return UIColor(red: 170/255.0, green: 152/255.0, blue: 114/255.0, alpha: 1)
    case "경의중앙선":
        return UIColor(red: 115/255.0, green: 199/255.0, blue: 166/255.0, alpha: 1)
    case "공항철도":
        return UIColor(red: 54/255.0, green: 129/255.0, blue: 183/255.0, alpha: 1)
    case "경춘선":
        return UIColor(red: 50/255.0, green: 198/255.0, blue: 166/255.0, alpha: 1)
    case "수인선":
        return UIColor(red: 255/255.0, green: 140/255.0, blue: 0, alpha: 1)
    case "분당선":
        return UIColor(red: 255/255.0, green: 140/255.0, blue: 0, alpha: 1)
    case "신분당선":
        return UIColor(red: 200/255.0, green: 33/255.0, blue: 39/255.0, alpha: 1)
    case "자기부상":
        return UIColor(red: 255/255.0, green: 205/255.0, blue: 18/255.0, alpha: 1)
    case "우이신설선":
        return UIColor(red: 162/255.0, green: 200/255.0, blue: 20/255.0, alpha: 1)
    default:
        return .black
    }
    
}



var metroStationCandidates:Array < MetroPair > = [AlarmMap.MetroPair(name: "4.19 민주묘지", line: "우이신설선"), AlarmMap.MetroPair(name: "가능", line: "1호선"), AlarmMap.MetroPair(name: "가락시장", line: "8호선"), AlarmMap.MetroPair(name: "가락시장", line: "3호선"), AlarmMap.MetroPair(name: "가산디지털단지", line: "1호선"), AlarmMap.MetroPair(name: "가산디지털단지", line: "7호선"), AlarmMap.MetroPair(name: "가양", line: "9호선"), AlarmMap.MetroPair(name: "가오리", line: "우이신설선"), AlarmMap.MetroPair(name: "가좌", line: "경의중앙선"), AlarmMap.MetroPair(name: "가천대", line: "분당선"), AlarmMap.MetroPair(name: "가평", line: "경춘선"), AlarmMap.MetroPair(name: "간석", line: "1호선"), AlarmMap.MetroPair(name: "갈매", line: "경춘선"), AlarmMap.MetroPair(name: "강남", line: "2호선"), AlarmMap.MetroPair(name: "강남구청", line: "분당선"), AlarmMap.MetroPair(name: "강남구청", line: "7호선"), AlarmMap.MetroPair(name: "강동", line: "5호선"), AlarmMap.MetroPair(name: "강동구청", line: "8호선"), AlarmMap.MetroPair(name: "강매", line: "경의중앙선"), AlarmMap.MetroPair(name: "강변", line: "2호선"), AlarmMap.MetroPair(name: "강촌", line: "경춘선"), AlarmMap.MetroPair(name: "개롱", line: "5호선"), AlarmMap.MetroPair(name: "개봉", line: "1호선"), AlarmMap.MetroPair(name: "개포동", line: "분당선"), AlarmMap.MetroPair(name: "개화", line: "9호선"), AlarmMap.MetroPair(name: "개화산", line: "5호선"), AlarmMap.MetroPair(name: "거여", line: "5호선"), AlarmMap.MetroPair(name: "건대입구", line: "7호선"), AlarmMap.MetroPair(name: "건대입구", line: "2호선"), AlarmMap.MetroPair(name: "검암", line: "공항철도"), AlarmMap.MetroPair(name: "경마공원", line: "4호선"), AlarmMap.MetroPair(name: "경복궁", line: "3호선"), AlarmMap.MetroPair(name: "경찰병원", line: "3호선"), AlarmMap.MetroPair(name: "계양", line: "공항철도"), AlarmMap.MetroPair(name: "고덕", line: "5호선"), AlarmMap.MetroPair(name: "고려대", line: "6호선"), AlarmMap.MetroPair(name: "고속터미널", line: "9호선"), AlarmMap.MetroPair(name: "고속터미널", line: "7호선"), AlarmMap.MetroPair(name: "고속터미널", line: "3호선"), AlarmMap.MetroPair(name: "고잔", line: "4호선"), AlarmMap.MetroPair(name: "곡산", line: "경의중앙선"), AlarmMap.MetroPair(name: "공덕", line: "공항철도"), AlarmMap.MetroPair(name: "공덕", line: "6호선"), AlarmMap.MetroPair(name: "공덕", line: "경의중앙선"), AlarmMap.MetroPair(name: "공덕", line: "5호선"), AlarmMap.MetroPair(name: "공릉(서울산업대입구)", line: "7호선"), AlarmMap.MetroPair(name: "공항시장", line: "9호선"), AlarmMap.MetroPair(name: "공항화물청사", line: "공항철도"), AlarmMap.MetroPair(name: "과천", line: "4호선"), AlarmMap.MetroPair(name: "관악", line: "1호선"), AlarmMap.MetroPair(name: "광나루(장신대)", line: "5호선"), AlarmMap.MetroPair(name: "광명사거리", line: "7호선"), AlarmMap.MetroPair(name: "광운대", line: "1호선"), AlarmMap.MetroPair(name: "광화문", line: "5호선"), AlarmMap.MetroPair(name: "광흥창", line: "6호선"), AlarmMap.MetroPair(name: "교대", line: "2호선"), AlarmMap.MetroPair(name: "교대", line: "3호선"), AlarmMap.MetroPair(name: "구로", line: "1호선"), AlarmMap.MetroPair(name: "구로디지털단지", line: "2호선"), AlarmMap.MetroPair(name: "구룡", line: "분당선"), AlarmMap.MetroPair(name: "구리", line: "경의중앙선"), AlarmMap.MetroPair(name: "구반포", line: "9호선"), AlarmMap.MetroPair(name: "구산", line: "6호선"), AlarmMap.MetroPair(name: "구성", line: "분당선"), AlarmMap.MetroPair(name: "구의", line: "2호선"), AlarmMap.MetroPair(name: "구일", line: "1호선"), AlarmMap.MetroPair(name: "구파발", line: "3호선"), AlarmMap.MetroPair(name: "국수", line: "경의중앙선"), AlarmMap.MetroPair(name: "국회의사당", line: "9호선"), AlarmMap.MetroPair(name: "군자(능동)", line: "5호선"), AlarmMap.MetroPair(name: "군자(능동)", line: "7호선"), AlarmMap.MetroPair(name: "군포", line: "1호선"), AlarmMap.MetroPair(name: "굴봉산", line: "경춘선"), AlarmMap.MetroPair(name: "굴포천", line: "7호선"), AlarmMap.MetroPair(name: "굽은다리(강동구민회관앞)", line: "5호선"), AlarmMap.MetroPair(name: "금곡", line: "경춘선"), AlarmMap.MetroPair(name: "금릉", line: "경의중앙선"), AlarmMap.MetroPair(name: "금정", line: "4호선"), AlarmMap.MetroPair(name: "금정", line: "1호선"), AlarmMap.MetroPair(name: "금천구청", line: "1호선"), AlarmMap.MetroPair(name: "금촌", line: "경의중앙선"), AlarmMap.MetroPair(name: "금호", line: "3호선"), AlarmMap.MetroPair(name: "기흥", line: "분당선"), AlarmMap.MetroPair(name: "길동", line: "5호선"), AlarmMap.MetroPair(name: "길음", line: "4호선"), AlarmMap.MetroPair(name: "김유정", line: "경춘선"), AlarmMap.MetroPair(name: "김포공항", line: "공항철도"), AlarmMap.MetroPair(name: "김포공항", line: "9호선"), AlarmMap.MetroPair(name: "김포공항", line: "5호선"), AlarmMap.MetroPair(name: "까치산", line: "5호선"), AlarmMap.MetroPair(name: "까치산", line: "2호선"), AlarmMap.MetroPair(name: "까치울", line: "7호선"), AlarmMap.MetroPair(name: "낙성대", line: "2호선"), AlarmMap.MetroPair(name: "남구로", line: "7호선"), AlarmMap.MetroPair(name: "남동인더스파크", line: "수인선"), AlarmMap.MetroPair(name: "남부터미널", line: "3호선"), AlarmMap.MetroPair(name: "남성", line: "7호선"), AlarmMap.MetroPair(name: "남영", line: "1호선"), AlarmMap.MetroPair(name: "남춘천", line: "경춘선"), AlarmMap.MetroPair(name: "남태령", line: "4호선"), AlarmMap.MetroPair(name: "남한산성입구(성남법원, 검찰청)", line: "8호선"), AlarmMap.MetroPair(name: "내방", line: "7호선"), AlarmMap.MetroPair(name: "노들", line: "9호선"), AlarmMap.MetroPair(name: "노량진", line: "1호선"), AlarmMap.MetroPair(name: "노량진", line: "9호선"), AlarmMap.MetroPair(name: "노원", line: "7호선"), AlarmMap.MetroPair(name: "노원", line: "4호선"), AlarmMap.MetroPair(name: "녹번", line: "3호선"), AlarmMap.MetroPair(name: "녹사평", line: "6호선"), AlarmMap.MetroPair(name: "녹양", line: "1호선"), AlarmMap.MetroPair(name: "녹천", line: "1호선"), AlarmMap.MetroPair(name: "논현", line: "7호선"), AlarmMap.MetroPair(name: "능곡", line: "경의중앙선"), AlarmMap.MetroPair(name: "단대오거리", line: "8호선"), AlarmMap.MetroPair(name: "달월", line: "수인선"), AlarmMap.MetroPair(name: "답십리", line: "5호선"), AlarmMap.MetroPair(name: "당고개", line: "4호선"), AlarmMap.MetroPair(name: "당산", line: "2호선"), AlarmMap.MetroPair(name: "당산", line: "9호선"), AlarmMap.MetroPair(name: "당정", line: "1호선"), AlarmMap.MetroPair(name: "대곡", line: "경의중앙선"), AlarmMap.MetroPair(name: "대곡", line: "3호선"), AlarmMap.MetroPair(name: "대공원", line: "4호선"), AlarmMap.MetroPair(name: "대림", line: "7호선"), AlarmMap.MetroPair(name: "대림", line: "2호선"), AlarmMap.MetroPair(name: "대모산", line: "분당선"), AlarmMap.MetroPair(name: "대방", line: "1호선"), AlarmMap.MetroPair(name: "대성리", line: "경춘선"), AlarmMap.MetroPair(name: "대야미", line: "4호선"), AlarmMap.MetroPair(name: "대청", line: "3호선"), AlarmMap.MetroPair(name: "대치", line: "3호선"), AlarmMap.MetroPair(name: "대화", line: "3호선"), AlarmMap.MetroPair(name: "대흥(서강대앞)", line: "6호선"), AlarmMap.MetroPair(name: "덕계", line: "1호선"), AlarmMap.MetroPair(name: "덕소", line: "경의중앙선"), AlarmMap.MetroPair(name: "덕정", line: "1호선"), AlarmMap.MetroPair(name: "도곡", line: "3호선"), AlarmMap.MetroPair(name: "도곡", line: "분당선"), AlarmMap.MetroPair(name: "도농", line: "경의중앙선"), AlarmMap.MetroPair(name: "도림천", line: "2호선"), AlarmMap.MetroPair(name: "도봉", line: "1호선"), AlarmMap.MetroPair(name: "도봉산", line: "1호선"), AlarmMap.MetroPair(name: "도봉산", line: "7호선"), AlarmMap.MetroPair(name: "도심", line: "경의중앙선"), AlarmMap.MetroPair(name: "도원", line: "1호선"), AlarmMap.MetroPair(name: "도화", line: "1호선"), AlarmMap.MetroPair(name: "독립문", line: "3호선"), AlarmMap.MetroPair(name: "독바위", line: "6호선"), AlarmMap.MetroPair(name: "독산", line: "1호선"), AlarmMap.MetroPair(name: "돌곶이", line: "6호선"), AlarmMap.MetroPair(name: "동대문", line: "1호선"), AlarmMap.MetroPair(name: "동대문", line: "4호선"), AlarmMap.MetroPair(name: "동대문역사문화공원", line: "4호선"), AlarmMap.MetroPair(name: "동대문역사문화공원", line: "5호선"), AlarmMap.MetroPair(name: "동대문역사문화공원", line: "2호선"), AlarmMap.MetroPair(name: "동대입구", line: "3호선"), AlarmMap.MetroPair(name: "동두천", line: "1호선"), AlarmMap.MetroPair(name: "동두천중앙", line: "1호선"), AlarmMap.MetroPair(name: "동묘앞", line: "1호선"), AlarmMap.MetroPair(name: "동묘앞", line: "6호선"), AlarmMap.MetroPair(name: "동암", line: "1호선"), AlarmMap.MetroPair(name: "동인천", line: "1호선"), AlarmMap.MetroPair(name: "동작", line: "4호선"), AlarmMap.MetroPair(name: "동작", line: "9호선"), AlarmMap.MetroPair(name: "두정", line: "1호선"), AlarmMap.MetroPair(name: "둔촌동", line: "5호선"), AlarmMap.MetroPair(name: "둔촌오륜", line: "9호선"), AlarmMap.MetroPair(name: "등촌", line: "9호선"), AlarmMap.MetroPair(name: "디지털미디어시티", line: "경의중앙선"), AlarmMap.MetroPair(name: "디지털미디어시티", line: "공항철도"), AlarmMap.MetroPair(name: "디지털미디어시티", line: "6호선"), AlarmMap.MetroPair(name: "뚝섬", line: "2호선"), AlarmMap.MetroPair(name: "뚝섬유원지", line: "7호선"), AlarmMap.MetroPair(name: "마곡", line: "5호선"), AlarmMap.MetroPair(name: "마곡나루", line: "공항철도"), AlarmMap.MetroPair(name: "마곡나루", line: "9호선"), AlarmMap.MetroPair(name: "마두", line: "3호선"), AlarmMap.MetroPair(name: "마들", line: "7호선"), AlarmMap.MetroPair(name: "마석", line: "경춘선"), AlarmMap.MetroPair(name: "마장", line: "5호선"), AlarmMap.MetroPair(name: "마천", line: "5호선"), AlarmMap.MetroPair(name: "마포", line: "5호선"), AlarmMap.MetroPair(name: "마포구청", line: "6호선"), AlarmMap.MetroPair(name: "망우", line: "경춘선"), AlarmMap.MetroPair(name: "망우", line: "경의중앙선"), AlarmMap.MetroPair(name: "망원", line: "6호선"), AlarmMap.MetroPair(name: "망월사", line: "1호선"), AlarmMap.MetroPair(name: "망포", line: "분당선"), AlarmMap.MetroPair(name: "매교", line: "분당선"), AlarmMap.MetroPair(name: "매봉", line: "3호선"), AlarmMap.MetroPair(name: "매탄권선", line: "분당선"), AlarmMap.MetroPair(name: "먹골", line: "7호선"), AlarmMap.MetroPair(name: "면목", line: "7호선"), AlarmMap.MetroPair(name: "명동", line: "4호선"), AlarmMap.MetroPair(name: "명일", line: "5호선"), AlarmMap.MetroPair(name: "명학", line: "1호선"), AlarmMap.MetroPair(name: "모란", line: "8호선"), AlarmMap.MetroPair(name: "모란", line: "분당선"), AlarmMap.MetroPair(name: "목동", line: "5호선"), AlarmMap.MetroPair(name: "몽촌토성(평화의문)", line: "8호선"), AlarmMap.MetroPair(name: "무악재", line: "3호선"), AlarmMap.MetroPair(name: "문래", line: "2호선"), AlarmMap.MetroPair(name: "문산", line: "경의중앙선"), AlarmMap.MetroPair(name: "문정", line: "8호선"), AlarmMap.MetroPair(name: "미금", line: "분당선"), AlarmMap.MetroPair(name: "미아", line: "4호선"), AlarmMap.MetroPair(name: "미아사거리", line: "4호선"), AlarmMap.MetroPair(name: "반월", line: "4호선"), AlarmMap.MetroPair(name: "반포", line: "7호선"), AlarmMap.MetroPair(name: "발산", line: "5호선"), AlarmMap.MetroPair(name: "방배", line: "2호선"), AlarmMap.MetroPair(name: "방이", line: "5호선"), AlarmMap.MetroPair(name: "방학", line: "1호선"), AlarmMap.MetroPair(name: "방화", line: "5호선"), AlarmMap.MetroPair(name: "배방", line: "1호선"), AlarmMap.MetroPair(name: "백마", line: "경의중앙선"), AlarmMap.MetroPair(name: "백석", line: "3호선"), AlarmMap.MetroPair(name: "백양리", line: "경춘선"), AlarmMap.MetroPair(name: "백운", line: "1호선"), AlarmMap.MetroPair(name: "버티고개", line: "6호선"), AlarmMap.MetroPair(name: "범계", line: "4호선"), AlarmMap.MetroPair(name: "별내", line: "경춘선"), AlarmMap.MetroPair(name: "병점", line: "1호선"), AlarmMap.MetroPair(name: "보라매", line: "7호선"), AlarmMap.MetroPair(name: "보문", line: "6호선"), AlarmMap.MetroPair(name: "보문", line: "우이신설선"), AlarmMap.MetroPair(name: "보산", line: "1호선"), AlarmMap.MetroPair(name: "보정", line: "분당선"), AlarmMap.MetroPair(name: "복정", line: "8호선"), AlarmMap.MetroPair(name: "복정", line: "분당선"), AlarmMap.MetroPair(name: "봉명", line: "1호선"), AlarmMap.MetroPair(name: "봉은사", line: "9호선"), AlarmMap.MetroPair(name: "봉천", line: "2호선"), AlarmMap.MetroPair(name: "봉화산", line: "6호선"), AlarmMap.MetroPair(name: "부개", line: "1호선"), AlarmMap.MetroPair(name: "부천", line: "1호선"), AlarmMap.MetroPair(name: "부천시청", line: "7호선"), AlarmMap.MetroPair(name: "부천종합운동장", line: "7호선"), AlarmMap.MetroPair(name: "부평", line: "1호선"), AlarmMap.MetroPair(name: "부평구청", line: "7호선"), AlarmMap.MetroPair(name: "북한산보국문", line: "우이신설선"), AlarmMap.MetroPair(name: "북한산우이", line: "우이신설선"), AlarmMap.MetroPair(name: "불광", line: "3호선"), AlarmMap.MetroPair(name: "불광", line: "6호선"), AlarmMap.MetroPair(name: "사가정", line: "7호선"), AlarmMap.MetroPair(name: "사당", line: "4호선"), AlarmMap.MetroPair(name: "사당", line: "2호선"), AlarmMap.MetroPair(name: "사릉", line: "경춘선"), AlarmMap.MetroPair(name: "사평", line: "9호선"), AlarmMap.MetroPair(name: "산본", line: "4호선"), AlarmMap.MetroPair(name: "산성", line: "8호선"), AlarmMap.MetroPair(name: "삼각지", line: "4호선"), AlarmMap.MetroPair(name: "삼각지", line: "6호선"), AlarmMap.MetroPair(name: "삼산체육관", line: "7호선"), AlarmMap.MetroPair(name: "삼성", line: "2호선"), AlarmMap.MetroPair(name: "삼성중앙", line: "9호선"), AlarmMap.MetroPair(name: "삼송", line: "3호선"), AlarmMap.MetroPair(name: "삼양", line: "우이신설선"), AlarmMap.MetroPair(name: "삼양사거리", line: "우이신설선"), AlarmMap.MetroPair(name: "삼전", line: "9호선"), AlarmMap.MetroPair(name: "상갈", line: "분당선"), AlarmMap.MetroPair(name: "상계", line: "4호선"), AlarmMap.MetroPair(name: "상도(중앙대앞)", line: "7호선"), AlarmMap.MetroPair(name: "상동", line: "7호선"), AlarmMap.MetroPair(name: "상록수", line: "4호선"), AlarmMap.MetroPair(name: "상봉", line: "경의중앙선"), AlarmMap.MetroPair(name: "상봉", line: "7호선"), AlarmMap.MetroPair(name: "상봉", line: "경춘선"), AlarmMap.MetroPair(name: "상수", line: "6호선"), AlarmMap.MetroPair(name: "상왕십리", line: "2호선"), AlarmMap.MetroPair(name: "상월곡(한국과학기술연구원)", line: "6호선"), AlarmMap.MetroPair(name: "상일동", line: "5호선"), AlarmMap.MetroPair(name: "상천", line: "경춘선"), AlarmMap.MetroPair(name: "새절(신사)", line: "6호선"), AlarmMap.MetroPair(name: "샛강", line: "9호선"), AlarmMap.MetroPair(name: "서강대", line: "경의중앙선"), AlarmMap.MetroPair(name: "서대문", line: "5호선"), AlarmMap.MetroPair(name: "서빙고", line: "경의중앙선"), AlarmMap.MetroPair(name: "서울", line: "4호선"), AlarmMap.MetroPair(name: "서울", line: "공항철도"), AlarmMap.MetroPair(name: "서울", line: "1호선"), AlarmMap.MetroPair(name: "서울", line: "경의중앙선"), AlarmMap.MetroPair(name: "서울대입구", line: "2호선"), AlarmMap.MetroPair(name: "서울숲", line: "분당선"), AlarmMap.MetroPair(name: "서정리", line: "1호선"), AlarmMap.MetroPair(name: "서초", line: "2호선"), AlarmMap.MetroPair(name: "서현", line: "분당선"), AlarmMap.MetroPair(name: "석계", line: "1호선"), AlarmMap.MetroPair(name: "석계", line: "6호선"), AlarmMap.MetroPair(name: "석수", line: "1호선"), AlarmMap.MetroPair(name: "석촌", line: "9호선"), AlarmMap.MetroPair(name: "석촌", line: "8호선"), AlarmMap.MetroPair(name: "석촌고분", line: "9호선"), AlarmMap.MetroPair(name: "선릉", line: "2호선"), AlarmMap.MetroPair(name: "선릉", line: "분당선"), AlarmMap.MetroPair(name: "선바위", line: "4호선"), AlarmMap.MetroPair(name: "선유도", line: "9호선"), AlarmMap.MetroPair(name: "선정릉", line: "9호선"), AlarmMap.MetroPair(name: "선정릉", line: "분당선"), AlarmMap.MetroPair(name: "성균관대", line: "1호선"), AlarmMap.MetroPair(name: "성수", line: "2호선"), AlarmMap.MetroPair(name: "성신여대입구", line: "4호선"), AlarmMap.MetroPair(name: "성신여대입구", line: "우이신설선"), AlarmMap.MetroPair(name: "성환", line: "1호선"), AlarmMap.MetroPair(name: "세류", line: "1호선"), AlarmMap.MetroPair(name: "세마", line: "1호선"), AlarmMap.MetroPair(name: "소래포구", line: "수인선"), AlarmMap.MetroPair(name: "소사", line: "1호선"), AlarmMap.MetroPair(name: "소요산", line: "1호선"), AlarmMap.MetroPair(name: "솔밭공원", line: "우이신설선"), AlarmMap.MetroPair(name: "솔샘", line: "우이신설선"), AlarmMap.MetroPair(name: "송내", line: "1호선"), AlarmMap.MetroPair(name: "송도", line: "수인선"), AlarmMap.MetroPair(name: "송정", line: "5호선"), AlarmMap.MetroPair(name: "송탄", line: "1호선"), AlarmMap.MetroPair(name: "송파", line: "8호선"), AlarmMap.MetroPair(name: "송파나루", line: "9호선"), AlarmMap.MetroPair(name: "수내", line: "분당선"), AlarmMap.MetroPair(name: "수락산", line: "7호선"), AlarmMap.MetroPair(name: "수리산", line: "4호선"), AlarmMap.MetroPair(name: "수색", line: "경의중앙선"), AlarmMap.MetroPair(name: "수서", line: "3호선"), AlarmMap.MetroPair(name: "수서", line: "분당선"), AlarmMap.MetroPair(name: "수원", line: "분당선"), AlarmMap.MetroPair(name: "수원", line: "1호선"), AlarmMap.MetroPair(name: "수원시청", line: "분당선"), AlarmMap.MetroPair(name: "수유", line: "4호선"), AlarmMap.MetroPair(name: "수진", line: "8호선"), AlarmMap.MetroPair(name: "숙대입구", line: "4호선"), AlarmMap.MetroPair(name: "숭실대입구(살피재)", line: "7호선"), AlarmMap.MetroPair(name: "숭의", line: "수인선"), AlarmMap.MetroPair(name: "시청", line: "1호선"), AlarmMap.MetroPair(name: "시청", line: "2호선"), AlarmMap.MetroPair(name: "신갈", line: "분당선"), AlarmMap.MetroPair(name: "신금호", line: "5호선"), AlarmMap.MetroPair(name: "신길", line: "5호선"), AlarmMap.MetroPair(name: "신길", line: "1호선"), AlarmMap.MetroPair(name: "신길온천", line: "4호선"), AlarmMap.MetroPair(name: "신내", line: "경춘선"), AlarmMap.MetroPair(name: "신내", line: "6호선"), AlarmMap.MetroPair(name: "신논현", line: "9호선"), AlarmMap.MetroPair(name: "신답", line: "2호선"), AlarmMap.MetroPair(name: "신당", line: "6호선"), AlarmMap.MetroPair(name: "신당", line: "2호선"), AlarmMap.MetroPair(name: "신대방", line: "2호선"), AlarmMap.MetroPair(name: "신대방삼거리", line: "7호선"), AlarmMap.MetroPair(name: "신도림", line: "1호선"), AlarmMap.MetroPair(name: "신도림", line: "2호선"), AlarmMap.MetroPair(name: "신림", line: "2호선"), AlarmMap.MetroPair(name: "신목동", line: "9호선"), AlarmMap.MetroPair(name: "신반포", line: "9호선"), AlarmMap.MetroPair(name: "신방화", line: "9호선"), AlarmMap.MetroPair(name: "신사", line: "3호선"), AlarmMap.MetroPair(name: "신설동", line: "우이신설선"), AlarmMap.MetroPair(name: "신설동", line: "1호선"), AlarmMap.MetroPair(name: "신설동", line: "2호선"), AlarmMap.MetroPair(name: "신용산", line: "4호선"), AlarmMap.MetroPair(name: "신원", line: "경의중앙선"), AlarmMap.MetroPair(name: "신이문", line: "1호선"), AlarmMap.MetroPair(name: "신정(은행정)", line: "5호선"), AlarmMap.MetroPair(name: "신정네거리", line: "2호선"), AlarmMap.MetroPair(name: "신중동", line: "7호선"), AlarmMap.MetroPair(name: "신창", line: "1호선"), AlarmMap.MetroPair(name: "신촌", line: "2호선"), AlarmMap.MetroPair(name: "신촌(경의.중앙선)", line: "경의중앙선"), AlarmMap.MetroPair(name: "신포", line: "수인선"), AlarmMap.MetroPair(name: "신풍", line: "7호선"), AlarmMap.MetroPair(name: "신흥", line: "8호선"), AlarmMap.MetroPair(name: "쌍문", line: "4호선"), AlarmMap.MetroPair(name: "쌍용(나사렛대)", line: "1호선"), AlarmMap.MetroPair(name: "아산", line: "1호선"), AlarmMap.MetroPair(name: "아신", line: "경의중앙선"), AlarmMap.MetroPair(name: "아차산(어린이대공원후문)", line: "5호선"), AlarmMap.MetroPair(name: "아현", line: "2호선"), AlarmMap.MetroPair(name: "안국", line: "3호선"), AlarmMap.MetroPair(name: "안산", line: "4호선"), AlarmMap.MetroPair(name: "안암(고대병원앞)", line: "6호선"), AlarmMap.MetroPair(name: "안양", line: "1호선"), AlarmMap.MetroPair(name: "암사", line: "8호선"), AlarmMap.MetroPair(name: "압구정", line: "3호선"), AlarmMap.MetroPair(name: "압구정로데오", line: "분당선"), AlarmMap.MetroPair(name: "애오개", line: "5호선"), AlarmMap.MetroPair(name: "야당", line: "경의중앙선"), AlarmMap.MetroPair(name: "야탑", line: "분당선"), AlarmMap.MetroPair(name: "약수", line: "3호선"), AlarmMap.MetroPair(name: "약수", line: "6호선"), AlarmMap.MetroPair(name: "양수", line: "경의중앙선"), AlarmMap.MetroPair(name: "양원", line: "경의중앙선"), AlarmMap.MetroPair(name: "양재", line: "3호선"), AlarmMap.MetroPair(name: "양정", line: "경의중앙선"), AlarmMap.MetroPair(name: "양주", line: "1호선"), AlarmMap.MetroPair(name: "양천구청", line: "2호선"), AlarmMap.MetroPair(name: "양천향교", line: "9호선"), AlarmMap.MetroPair(name: "양평", line: "5호선"), AlarmMap.MetroPair(name: "양평", line: "경의중앙선"), AlarmMap.MetroPair(name: "어린이대공원(세종대)", line: "7호선"), AlarmMap.MetroPair(name: "언주", line: "9호선"), AlarmMap.MetroPair(name: "여의나루", line: "5호선"), AlarmMap.MetroPair(name: "여의도", line: "5호선"), AlarmMap.MetroPair(name: "여의도", line: "9호선"), AlarmMap.MetroPair(name: "역곡", line: "1호선"), AlarmMap.MetroPair(name: "역삼", line: "2호선"), AlarmMap.MetroPair(name: "역촌", line: "6호선"), AlarmMap.MetroPair(name: "연수", line: "수인선"), AlarmMap.MetroPair(name: "연신내", line: "3호선"), AlarmMap.MetroPair(name: "연신내", line: "6호선"), AlarmMap.MetroPair(name: "염창", line: "9호선"), AlarmMap.MetroPair(name: "영등포", line: "1호선"), AlarmMap.MetroPair(name: "영등포구청", line: "2호선"), AlarmMap.MetroPair(name: "영등포구청", line: "5호선"), AlarmMap.MetroPair(name: "영등포시장", line: "5호선"), AlarmMap.MetroPair(name: "영종", line: "공항철도"), AlarmMap.MetroPair(name: "영통", line: "분당선"), AlarmMap.MetroPair(name: "오금", line: "3호선"), AlarmMap.MetroPair(name: "오금", line: "5호선"), AlarmMap.MetroPair(name: "오류동", line: "1호선"), AlarmMap.MetroPair(name: "오리", line: "분당선"), AlarmMap.MetroPair(name: "오목교(목동운동장앞)", line: "5호선"), AlarmMap.MetroPair(name: "오빈", line: "경의중앙선"), AlarmMap.MetroPair(name: "오산", line: "1호선"), AlarmMap.MetroPair(name: "오산대", line: "1호선"), AlarmMap.MetroPair(name: "오이도", line: "4호선"), AlarmMap.MetroPair(name: "오이도", line: "수인선"), AlarmMap.MetroPair(name: "옥수", line: "3호선"), AlarmMap.MetroPair(name: "옥수", line: "경의중앙선"), AlarmMap.MetroPair(name: "온수", line: "7호선"), AlarmMap.MetroPair(name: "온수", line: "1호선"), AlarmMap.MetroPair(name: "온양온천", line: "1호선"), AlarmMap.MetroPair(name: "올림픽공원", line: "9호선"), AlarmMap.MetroPair(name: "올림픽공원(한국체대)", line: "5호선"), AlarmMap.MetroPair(name: "왕십리", line: "분당선"), AlarmMap.MetroPair(name: "왕십리", line: "경의중앙선"), AlarmMap.MetroPair(name: "왕십리", line: "5호선"), AlarmMap.MetroPair(name: "왕십리", line: "2호선"), AlarmMap.MetroPair(name: "외대앞", line: "1호선"), AlarmMap.MetroPair(name: "용답", line: "2호선"), AlarmMap.MetroPair(name: "용두", line: "2호선"), AlarmMap.MetroPair(name: "용마산", line: "7호선"), AlarmMap.MetroPair(name: "용문", line: "경의중앙선"), AlarmMap.MetroPair(name: "용산", line: "경의중앙선"), AlarmMap.MetroPair(name: "용산", line: "1호선"), AlarmMap.MetroPair(name: "용유", line: "자기부상"), AlarmMap.MetroPair(name: "우장산", line: "5호선"), AlarmMap.MetroPair(name: "운길산", line: "경의중앙선"), AlarmMap.MetroPair(name: "운서", line: "공항철도"), AlarmMap.MetroPair(name: "운정", line: "경의중앙선"), AlarmMap.MetroPair(name: "워터파크", line: "자기부상"), AlarmMap.MetroPair(name: "원당", line: "3호선"), AlarmMap.MetroPair(name: "원덕", line: "경의중앙선"), AlarmMap.MetroPair(name: "원인재", line: "수인선"), AlarmMap.MetroPair(name: "원흥", line: "3호선"), AlarmMap.MetroPair(name: "월계", line: "1호선"), AlarmMap.MetroPair(name: "월곡(동덕여대)", line: "6호선"), AlarmMap.MetroPair(name: "월곶", line: "수인선"), AlarmMap.MetroPair(name: "월드컵경기장(성산)", line: "6호선"), AlarmMap.MetroPair(name: "월롱", line: "경의중앙선"), AlarmMap.MetroPair(name: "을지로3가", line: "3호선"), AlarmMap.MetroPair(name: "을지로3가", line: "2호선"), AlarmMap.MetroPair(name: "을지로4가", line: "2호선"), AlarmMap.MetroPair(name: "을지로4가", line: "5호선"), AlarmMap.MetroPair(name: "을지로입구", line: "2호선"), AlarmMap.MetroPair(name: "응봉", line: "경의중앙선"), AlarmMap.MetroPair(name: "응암순환(상선)", line: "6호선"), AlarmMap.MetroPair(name: "의왕", line: "1호선"), AlarmMap.MetroPair(name: "의정부", line: "1호선"), AlarmMap.MetroPair(name: "이대", line: "2호선"), AlarmMap.MetroPair(name: "이매", line: "분당선"), AlarmMap.MetroPair(name: "이촌", line: "4호선"), AlarmMap.MetroPair(name: "이촌", line: "경의중앙선"), AlarmMap.MetroPair(name: "이태원", line: "6호선"), AlarmMap.MetroPair(name: "인덕원", line: "4호선"), AlarmMap.MetroPair(name: "인천", line: "1호선"), AlarmMap.MetroPair(name: "인천", line: "수인선"), AlarmMap.MetroPair(name: "인천공항1터미널", line: "공항철도"), AlarmMap.MetroPair(name: "인천공항2터미널", line: "공항철도"), AlarmMap.MetroPair(name: "인천논현", line: "수인선"), AlarmMap.MetroPair(name: "인하대", line: "수인선"), AlarmMap.MetroPair(name: "일산", line: "경의중앙선"), AlarmMap.MetroPair(name: "일원", line: "3호선"), AlarmMap.MetroPair(name: "잠실", line: "8호선"), AlarmMap.MetroPair(name: "잠실", line: "2호선"), AlarmMap.MetroPair(name: "잠실나루", line: "2호선"), AlarmMap.MetroPair(name: "잠실새내", line: "2호선"), AlarmMap.MetroPair(name: "잠원", line: "3호선"), AlarmMap.MetroPair(name: "장기주차장", line: "자기부상"), AlarmMap.MetroPair(name: "장승배기", line: "7호선"), AlarmMap.MetroPair(name: "장암", line: "7호선"), AlarmMap.MetroPair(name: "장지", line: "8호선"), AlarmMap.MetroPair(name: "장한평", line: "5호선"), AlarmMap.MetroPair(name: "정릉", line: "우이신설선"), AlarmMap.MetroPair(name: "정발산", line: "3호선"), AlarmMap.MetroPair(name: "정부과천청사", line: "4호선"), AlarmMap.MetroPair(name: "정왕", line: "4호선"), AlarmMap.MetroPair(name: "정자", line: "분당선"), AlarmMap.MetroPair(name: "제기동", line: "1호선"), AlarmMap.MetroPair(name: "제물포", line: "1호선"), AlarmMap.MetroPair(name: "종각", line: "1호선"), AlarmMap.MetroPair(name: "종로3가", line: "5호선"), AlarmMap.MetroPair(name: "종로3가", line: "1호선"), AlarmMap.MetroPair(name: "종로3가", line: "3호선"), AlarmMap.MetroPair(name: "종로5가", line: "1호선"), AlarmMap.MetroPair(name: "종합운동장", line: "2호선"), AlarmMap.MetroPair(name: "종합운동장", line: "9호선"), AlarmMap.MetroPair(name: "주안", line: "1호선"), AlarmMap.MetroPair(name: "주엽", line: "3호선"), AlarmMap.MetroPair(name: "죽전", line: "분당선"), AlarmMap.MetroPair(name: "중계", line: "7호선"), AlarmMap.MetroPair(name: "중곡", line: "7호선"), AlarmMap.MetroPair(name: "중동", line: "1호선"), AlarmMap.MetroPair(name: "중랑", line: "경의중앙선"), AlarmMap.MetroPair(name: "중앙", line: "4호선"), AlarmMap.MetroPair(name: "중앙보훈병원", line: "9호선"), AlarmMap.MetroPair(name: "중화", line: "7호선"), AlarmMap.MetroPair(name: "증미", line: "9호선"), AlarmMap.MetroPair(name: "증산(명지대앞)", line: "6호선"), AlarmMap.MetroPair(name: "지제", line: "1호선"), AlarmMap.MetroPair(name: "지축", line: "3호선"), AlarmMap.MetroPair(name: "지평", line: "경의중앙선"), AlarmMap.MetroPair(name: "지행", line: "1호선"), AlarmMap.MetroPair(name: "직산", line: "1호선"), AlarmMap.MetroPair(name: "진위", line: "1호선"), AlarmMap.MetroPair(name: "창동", line: "4호선"), AlarmMap.MetroPair(name: "창동", line: "1호선"), AlarmMap.MetroPair(name: "창신", line: "6호선"), AlarmMap.MetroPair(name: "천마산", line: "경춘선"), AlarmMap.MetroPair(name: "천안", line: "1호선"), AlarmMap.MetroPair(name: "천왕", line: "7호선"), AlarmMap.MetroPair(name: "천호(풍납토성)", line: "5호선"), AlarmMap.MetroPair(name: "천호(풍납토성)", line: "8호선"), AlarmMap.MetroPair(name: "철산", line: "7호선"), AlarmMap.MetroPair(name: "청구", line: "5호선"), AlarmMap.MetroPair(name: "청구", line: "6호선"), AlarmMap.MetroPair(name: "청담", line: "7호선"), AlarmMap.MetroPair(name: "청라국제도시", line: "공항철도"), AlarmMap.MetroPair(name: "청량리", line: "경의중앙선"), AlarmMap.MetroPair(name: "청량리", line: "1호선"), AlarmMap.MetroPair(name: "청명", line: "분당선"), AlarmMap.MetroPair(name: "청평", line: "경춘선"), AlarmMap.MetroPair(name: "초지", line: "4호선"), AlarmMap.MetroPair(name: "총신대입구(이수)", line: "4호선"), AlarmMap.MetroPair(name: "총신대입구(이수)", line: "7호선"), AlarmMap.MetroPair(name: "춘의역", line: "7호선"), AlarmMap.MetroPair(name: "춘천", line: "경춘선"), AlarmMap.MetroPair(name: "충무로", line: "3호선"), AlarmMap.MetroPair(name: "충무로", line: "4호선"), AlarmMap.MetroPair(name: "충정로", line: "5호선"), AlarmMap.MetroPair(name: "충정로", line: "2호선"), AlarmMap.MetroPair(name: "탄현", line: "경의중앙선"), AlarmMap.MetroPair(name: "태릉입구", line: "7호선"), AlarmMap.MetroPair(name: "태릉입구", line: "6호선"), AlarmMap.MetroPair(name: "태평", line: "분당선"), AlarmMap.MetroPair(name: "퇴계원", line: "경춘선"), AlarmMap.MetroPair(name: "파라다이스 시티", line: "자기부상"), AlarmMap.MetroPair(name: "파주", line: "경의중앙선"), AlarmMap.MetroPair(name: "팔당", line: "경의중앙선"), AlarmMap.MetroPair(name: "평내호평", line: "경춘선"), AlarmMap.MetroPair(name: "평촌", line: "4호선"), AlarmMap.MetroPair(name: "평택", line: "1호선"), AlarmMap.MetroPair(name: "풍산", line: "경의중앙선"), AlarmMap.MetroPair(name: "하계", line: "7호선"), AlarmMap.MetroPair(name: "학동", line: "7호선"), AlarmMap.MetroPair(name: "학여울", line: "3호선"), AlarmMap.MetroPair(name: "한강진", line: "6호선"), AlarmMap.MetroPair(name: "한남", line: "경의중앙선"), AlarmMap.MetroPair(name: "한대앞", line: "4호선"), AlarmMap.MetroPair(name: "한성대입구", line: "4호선"), AlarmMap.MetroPair(name: "한성백제", line: "9호선"), AlarmMap.MetroPair(name: "한양대", line: "2호선"), AlarmMap.MetroPair(name: "한티", line: "분당선"), AlarmMap.MetroPair(name: "합동청사", line: "자기부상"), AlarmMap.MetroPair(name: "합정", line: "2호선"), AlarmMap.MetroPair(name: "합정", line: "6호선"), AlarmMap.MetroPair(name: "행당", line: "5호선"), AlarmMap.MetroPair(name: "행신", line: "경의중앙선"), AlarmMap.MetroPair(name: "혜화", line: "4호선"), AlarmMap.MetroPair(name: "호구포", line: "수인선"), AlarmMap.MetroPair(name: "홍대입구", line: "공항철도"), AlarmMap.MetroPair(name: "홍대입구", line: "2호선"), AlarmMap.MetroPair(name: "홍대입구", line: "경의중앙선"), AlarmMap.MetroPair(name: "홍제", line: "3호선"), AlarmMap.MetroPair(name: "화계", line: "우이신설선"), AlarmMap.MetroPair(name: "화곡", line: "5호선"), AlarmMap.MetroPair(name: "화랑대(서울여대입구)", line: "6호선"), AlarmMap.MetroPair(name: "화서", line: "1호선"), AlarmMap.MetroPair(name: "화전", line: "경의중앙선"), AlarmMap.MetroPair(name: "화정", line: "3호선"), AlarmMap.MetroPair(name: "회기", line: "1호선"), AlarmMap.MetroPair(name: "회기", line: "경의중앙선"), AlarmMap.MetroPair(name: "회룡", line: "1호선"), AlarmMap.MetroPair(name: "회현", line: "4호선"), AlarmMap.MetroPair(name: "효창공원앞", line: "6호선"), AlarmMap.MetroPair(name: "효창공원앞", line: "경의중앙선"), AlarmMap.MetroPair(name: "흑석", line: "9호선")]

