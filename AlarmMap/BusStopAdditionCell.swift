//
//  BusStopAdditionCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/05/28.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusStopAdditionCell: UITableViewCell {
    
    @IBOutlet var busStopNameLabel: UILabel!
    
    @IBOutlet var busStopInfoLabel: UILabel!
    
    @IBOutlet var addButton: UIButton!
    
    var cellIndex = 0
    var arsId:String? = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
