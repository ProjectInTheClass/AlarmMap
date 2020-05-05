//
//  RouteTableViewCell.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/04/24.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    @IBOutlet var routeTitle: UILabel!
    
    @IBOutlet var routeSubtitle: UILabel!
    
    @IBOutlet var routeSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func routeSwitchTapped(_ sender: Any) {
        if(routeSwitch.isOn){
            routeTitle.textColor = UIColor.black
        }
        else {
            routeTitle.textColor = UIColor.gray
        }
    }
}
