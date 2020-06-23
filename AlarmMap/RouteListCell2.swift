//
//  RouteListCell2.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteListCell2: UITableViewCell {
    
    @IBOutlet var routeTitleLabel: UILabel!
    
    @IBOutlet var routeSubtitleLabel: UILabel!
    
    var routeInfo:RouteInfo? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
