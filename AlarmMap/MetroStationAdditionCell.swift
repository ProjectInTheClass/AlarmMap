//
//  MetroStationAdditionCell.swift
//  AlarmMap
//
//  Created by SeoungJun Oh on 2020/06/08.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class MetroStationAdditionCell: UITableViewCell {

    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var stationNameLabel: UILabel!
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
