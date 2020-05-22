//
//  RouteTableViewCell.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/04/24.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit

class RouteListCell1: UITableViewCell {

    @IBOutlet var routeTitleLabel: UILabel!
    
    @IBOutlet var routeSubtitleLabel: UILabel!
    
    @IBOutlet var routeAlarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func routeSwitchTapped(_ sender: Any) {
        if(routeAlarmSwitch.isOn){
            routeTitleLabel.textColor = UIColor.black
        }
        else {
            routeTitleLabel.textColor = UIColor.gray
        }
    }
}
