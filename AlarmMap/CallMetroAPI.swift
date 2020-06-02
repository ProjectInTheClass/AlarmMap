//
//  CallMetroAPI.swift
//  AlarmMap
//
//  Created by SeoungJun Oh on 2020/06/02.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyXMLParser

func getMetroURL(url:String, params:[String: Any]) -> URL {
    let urlParams = params.compactMap({ (key, value) -> String in
    return "\(value)"
    }).joined(separator: "/")
    let withURL = url + "/\(urlParams)"
    let encoded = withURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! //+ "&serviceKey=" + metroKey
    return URL(string:encoded)!
}

func getMetroStationData(keyword:String) {
    let SeoulStationURL = "http://swopenAPI.seoul.go.kr/api/subway"
    let url = getMetroURL(url: SeoulStationURL, params: ["key": metroKey+"/xml/realtimeStationArrival/0/40/왕십리"])//["key": metroKey, "xml": "xml","serviceName":"StationDayTrnsitNmpr","startIndex":1,"endIndex":5])
    print(url)
    AF.request(url,method: .get).validate()
    .responseString { response in
    print(" - API url: \(String(describing: response.request!))")

    //if case success
    switch response.result {
        case .success(let value):
                let responseString = NSString(data: response.data!, encoding:
                String.Encoding.utf8.rawValue )
                let xml = try! XML.parse(String(responseString!))
                print(responseString)
                
                for element in xml["realtimeStationArrival"]["row"] {
                    
                    if let trainLineNm =
                        element["trainLineNm"].text, let arvlMsg2 = element["arvlMsg2"].text, let arvlMsg3 = element["arvlMsg3"].text, let statnNm = element["statnNm"].text {
                        print("trainLineNm = \(trainLineNm), arvlMsg2 = \(arvlMsg2), arvlMsg3 = \(arvlMsg3), statnNm = \(statnNm)")
                        
                    }
                }
                
        case .failure(let error):
            print(error)
        }
    }
}
