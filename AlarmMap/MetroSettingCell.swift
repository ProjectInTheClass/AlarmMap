//
//  MetroSettingCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/28.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class MetroSettingCell: UITableViewCell {

    @IBOutlet var lineLabel: UILabel!
    
    @IBOutlet var stationNameLabel: UILabel!
    
    @IBOutlet var directionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        lineLabel.layer.cornerRadius = 5
        lineLabel.layer.masksToBounds = true
        // Configure the view for the selected state
    }

}
