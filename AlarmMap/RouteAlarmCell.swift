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
    // TODO - 스위치로 RouteAlarm.isOn 조절
    
    // by CSEDTD
    var routeAlarm:RouteAlarm? = nil

    
    // by CSEDTD
    @IBAction func alarmOnOff(_ sender: UISwitch) {
        routeAlarm?.isOn = sender.isOn
        // TODO
        print(routeAlarm?.isOn)
        if !sender.isOn {
            routeAlarm?.detach()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // TODO - 알람을 선택했으면 AlarmSettingTableViewController로 들어가게 해야 함

        // Configure the view for the selected state
    }

}
