//
//  MetroStationCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/23.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class MetroStationCell: UITableViewCell {

    
    @IBOutlet var lineLabel: UILabel!
    
    @IBOutlet var StationNameLabel: UILabel!
    
    @IBOutlet var directionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}