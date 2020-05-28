//
//  BusSettingCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/24.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusSettingCell: UITableViewCell {
    
    @IBOutlet var busStopNameLabel: UILabel!
    
    @IBOutlet var busStopDirectionLabel: UILabel!
    
    @IBOutlet var busListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
