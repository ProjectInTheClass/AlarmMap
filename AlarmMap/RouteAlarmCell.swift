//
//  RouteAlarmCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/22.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteAlarmCell: UITableViewCell {

    @IBOutlet var routeAlarmTimeLabel: UILabel!
    
    @IBOutlet var routeAlarmSubtitleLabel: UILabel!
    
    @IBOutlet var routeAlarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
