//
//  BusListCell.swift
//  AlarmMap
//
//  Created by 김요환 on 2020/06/04.
//  Copyright © 2020 AalrmMapCompany. All rights reserved.
//

import UIKit

class BusListCell: UITableViewCell {
    
    @IBOutlet var busNumberLabel: UILabel!
    
    @IBOutlet var addButton: UIButton!
    
    var busIndex:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
