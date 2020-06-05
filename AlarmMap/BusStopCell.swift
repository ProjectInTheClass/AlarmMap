//
//  BusStopTableViewCell.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/05/06.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit

class BusStopCell: UITableViewCell {

    @IBOutlet var busStopNameLabel: UILabel!
    
    @IBOutlet var busStopDirectionLabel: UILabel!
    
    var busStop:BusStop? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func busListSettingButtonTapped(_ sender: Any) {
    }
}
