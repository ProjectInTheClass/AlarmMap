//
//  RouteSearchResultCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/20.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteSearchResultCell: UITableViewCell {

    @IBOutlet var totalTimeLabel: UILabel!
    
    @IBOutlet var routeInfoLabel: UILabel!

    @IBOutlet var routePreviewBarView: RoutePreviewBarView!
    
    var routeSearchResultIndex = 0
    
    /* <-- searchList 쓰자
    // 0623 TODO by CSEDTD - new fields
    // 참고: RouteData.swift --> RouteInfo
    var totalDisplacement: Double
    var totalTime: Int
    var totalWalk: Int
    var totalCost: Int
    var transferCount: Int
    var route: [WayPoint]
     */
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
