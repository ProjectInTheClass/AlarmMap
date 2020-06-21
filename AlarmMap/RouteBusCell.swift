//
//  RouteBusCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/21.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class RouteBusCell: UITableViewCell {

    @IBOutlet var busSymbolImageView: UIImageView!
    
    @IBOutlet var busStopNameLabel: UILabel!
    
    @IBOutlet var busStopIdLabel: UILabel!
    
    @IBOutlet var busListLabel: UILabel!
    
    @IBOutlet var numOfBusStopsPassingByLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
