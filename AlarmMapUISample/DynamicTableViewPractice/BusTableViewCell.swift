//
//  BusTableViewCell.swift
//  DynamicTableViewPractice
//
//  Created by 김요환 on 2020/05/06.
//  Copyright © 2020 Kloong. All rights reserved.
//

import UIKit

class BusTableViewCell: UITableViewCell {

    @IBOutlet var busNumberLabel: UILabel!
    
    @IBOutlet var firstBusRemainingTimeLabel: UILabel!
    
    @IBOutlet var secondBusRemainingTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
