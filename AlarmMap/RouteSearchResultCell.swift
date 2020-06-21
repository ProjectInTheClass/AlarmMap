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
    
    @IBOutlet var totalDisplacementLabel: UILabel!
    
    @IBOutlet var totalCostLabel: UILabel!
    
    @IBOutlet var transferCountLabel: UILabel!
    
    var routeSearchResultIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
